<!---
	Name         : scopeCache_Report
	Author       : Raymond Camden (jedimaster@mindseye.com)
	Created      : February 14, 2005
	Last Updated : February 14, 2005
	History      : 
	Purpose		 : Retrieves and reports on cached data.
	Documentation:
	
	License		 : Use this as you will. If you enjoy it and it helps your application, 
				   consider sending me something from my Amazon wish list:
				   http://www.amazon.com/o/registry/2TCL1D08EZEYE
--->

<cfparam name="attributes.scope" default="application">

<cfif not listFindNoCase("application,session,server",attributes.scope)>
	<cfthrow message="Invalid scope passed. Must be one of: application, session, server.">
</cfif>

<cfif isDefined("url.clear") and len(url.clear) and attributes.scope is not "session">
	<cf_scopecache scope="#attributes.scope#" name="#url.clear#" clear=true>
</cfif>

<cfif isDefined("url.clearAll") and attributes.scope is not "session">
	<cf_scopecache scope="#attributes.scope#" clearAll=true>
</cfif>

<cfif attributes.scope is not "session">
	<!--- create pointer to scope --->
	<cfset ptr = structGet(attributes.scope & ".scopecache")>
<cfelse>
	<!--- hack for sessions --->
	<cfset tracker = createObject("java", "coldfusion.runtime.SessionTracker")>
	<cfset sessions = tracker.getSessionCollection(application.applicationName)>
	<cfset ptr = structNew()>
	<cfloop item="key" collection="#sessions#">
		<cfif structKeyExists(sessions[key], "scopeCache")>
			<!--- copy their data, but add session id to name --->
			<cfloop item="innerkey" collection="#sessions[key].scopeCache#">
				<cfset ptr[innerkey & " (#sessions[key].sessionid#)"] = duplicate(sessions[key].scopeCache[innerkey])>
			</cfloop>
		</cfif>
	</cfloop>
</cfif>

<cfset numItems = structCount(ptr)>
<cfif not structIsEmpty(ptr)>
	<cfset keys = structKeyArray(ptr)>
	<cfset arraySort(keys, "textnocase")>
</cfif>

<cfoutput>
<style>
.scr_header {
	background-color: ##0000a0;
	color: white;
	font-family: arial;
}
.scr_colheader {
	background-color: ##8000ff;
	color: white;
	font-family: arial;
}
</style>

<p>
<table border="1" width="100%">
	<tr class="scr_header">
		<td colspan="7"><b>ScopeCache Report: #attributes.scope# Scope</b></td>
	</tr>
	<cfif not structIsEmpty(ptr)>
		<tr class="scr_colheader">
			<td><b>Name</b></td>
			<td><b>Dependancies</b></td>
			<td><b>Age</b></td>
			<td><b>Expires (## of Minutes)</b></td>
			<td><b>Hit Count</b></td>
			<td><b>Size (Kb)</b></td>
			<td>&nbsp;</td>
		</tr>

		<cfset cached_value = CreateObject("java", "java.lang.String")> 
		<cfloop index="x" from="1" to="#numItems#">
			<tr>
				<td>#keys[x]#</td>
				<td>
					<cfif len(ptr[keys[x]].dependancies)>
						#ptr[keys[x]].dependancies#
					<cfelse>
						No dependancies
					</cfif>
				</td>
				<td>
				#dateDiff("n", ptr[keys[x]].created, now())# minute(s).
				</td>
				<td>
					<cfif year(ptr[keys[x]].timeout) gte 3999>
						<cfset timeout = "Never">
					<cfelse>
						<cfset timeout = dateDiff("n",now(), ptr[keys[x]].timeout) & " minute(s).">
					</cfif>
					<cfif timeout gte 1>
						#timeout#
					<cfelse>
						Expired
					</cfif>
				</td>
				<td>#numberFormat(ptr[keys[x]].hitcount)#</td>
				<cfset cached_value = ptr[keys[x]].value>    <!--- added by brett --->
				<cfif isSimpleValue(cached_value)>
					<cftry>
						<cfset size = arrayLen(cached_value.getBytes())>
						<cfcatch>
							<cfset size = "Unknown">
						</cfcatch>
					</cftry>
				</cfif>
				<!---
				<cfif isNumeric(size)>
					<cfset size = size/1024>
				</cfif>
				--->
				<td><cfif size neq "Unknown">#numberFormat(size/1024)# KB<cfelse>#size#</cfif></td><!---  added by brett ---> 				
				
				<cfif attributes.scope is not "session">
					<td><a href="#cgi.script_name#?clear=#urlEncodedFormat(keys[x])#">Clear</a></td>
				<cfelse>
					<td>&nbsp;</td>
				</cfif>
			</tr>
		</cfloop>
		<tr>
			<td colspan="7">
			#numItems# total item(s). <a href="#cgi.script_name#?clearAll=1">Clear All</a>
			</td>
		</tr>
	<cfelse>
		<tr>
			<td colspan="5">No cached items.</td>
		</tr>
	</cfif>
</table>
</p>
</cfoutput>