

<cfset fCache = expandPath("./fcache.txt")>

<cfif isDefined("url.clear")>
	<cf_scopeCache scope="file" file="#fCache#" name="foo" clear=true>
</cfif>

<cfset t = 60*60>
<cf_scopeCache name="foo" scope="file" file="#fCache#" timeout="#t#">

	<cfsilent>
	<cfloop index="x" from=1 to=20000>
		<cfset c = x * 2 / 5.2>
	</cfloop>
	</cfsilent>
	<cfoutput><p>The result is #c#, generated at #dateFormat(now())# #timeFormat(now(),"h:mm:ss tt")#</p></cfoutput>
	
</cf_scopeCache>



<p>
<a href="test4.cfm?clear=1">Clear cache</a>
</p>


