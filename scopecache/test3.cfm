<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfif isDefined("url.clear")>
	<cf_scopeCache scope="application" name="foo" clear=true>
</cfif>

<cfset t = 60*60>
<cf_scopeCache name="foo" scope="application" timeout="#t#" dependancies="foo2">

	<cfsilent>
	<cfloop index="x" from=1 to=200>
		<cfset c = x * 2 / 5.2>
	</cfloop>
	</cfsilent>
	<cfoutput>The result is #c#, generated at #dateFormat(now())# #timeFormat(now(),"h:mm:ss tt")#</cfoutput>
	
</cf_scopeCache>

<p>
testing inline: 
<cf_scopeCache name="foo2" scope="application" data="#now()#" r_Data="y" dependancies="foo3"/>
<cfoutput>The value of y is #y#</cfoutput>
</p>

<p>
testing inline2: 
<cf_scopeCache name="foo3" scope="application" data="#now()# ray #randrange(1,100)#" r_Data="z"/>
<cfoutput>The value of z is #z#</cfoutput>
</p>

<p>
<a href="test.cfm?clear=1">Clear cache</a>
</p>

<cfdump var="#application#">
</body>
</html>
