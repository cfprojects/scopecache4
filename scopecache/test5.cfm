<cfset begin = getTickCount()>

<cfscript>
function verySlow(x) {
	sleep(2000);
	return arguments.x*2;
}
//must copy to a scope that scopeCache can access
request.verySlow = verySlow;
</cfscript>

<cf_scopeCache name="cacheddef" scope="application" r_Data="cacheVariable" deferreddata="request.verySlow(2)" />
<cfoutput>from cache: #cacheVariable#</cfoutput>

<cfset end = getTickCount() - begin>

<cfoutput><br/>Time to make this page: #end#ms</cfoutput>