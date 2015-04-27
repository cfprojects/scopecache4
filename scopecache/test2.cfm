

<cfset t = 60*60>
<cfset thistime = getTickCount()>
<cf_scopeCache name="foo" scope="request" timeout="#t#">

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
Total time to generate round 1: #totaltime# ms.
</p>
</cfoutput>

<cfset thistime = getTickCount()>
<cf_scopeCache name="foo" scope="request" timeout="#t#">

	<cfsilent>
	<cfloop index="x" from=1 to=990000>
		<cfset c = x * 2 / 5.2>
	</cfloop>
	</cfsilent>
	<cfoutput>The result is #c#, generated at #dateFormat(now())# #timeFormat(now(),"h:mm:ss tt")#</cfoutput>
	
</cf_scopeCache>
<cfset totaltime = getTickCount() - thistime>

<cfoutput>
<p>
Total time to generate round 2: #totaltime# ms.
</p>
</cfoutput>

<cfdump var="#request#" label="Request">