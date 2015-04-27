<h1>ScopeCache Demo</h1>

<cfif isDefined("url.clear")>
	<cf_scopeCache scope="application" name="foo" clear=true>
</cfif>

<cfset t = 60*60>
<cfset thistime = getTickCount()>
<cf_scopeCache name="foo" scope="application" timeout="#t#">

	<cfsilent>
	<cfloop index="x" from=1 to=990000>
		<cfset c = x * 2 / 5.2>
	</cfloop>
	</cfsilent>
	<cfset sleep(2000)>
	<cfoutput>The result is #c#, generated at #dateFormat(now())# #timeFormat(now(),"h:mm:ss tt")#</cfoutput>
	
</cf_scopeCache>
<cfset totaltime = getTickCount() - thistime>

<cfoutput>
<p>
Total time to generate: #totaltime# ms.
</p>
</cfoutput>

<p>
<a href="test.cfm?clear=1">Clear cache</a>
</p>

<cfdump var="#application#" label="Application">
