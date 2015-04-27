LICENSE 
Copyright 2010-2012 Raymond Camden

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
   
   
If you find this custom tag worthy, I have a Amazon wish list set up (www.amazon.com/o/registry/2TCL1D08EZEYE ).

INSTRUCTIONS

To use this custom tag, please see the usage information in the file itself.
Any problems or questions, email me at ray@camdenfamily.com.

HISTORY:
December 6, 2011: Shawn Holmes (shawn.a.holmes@gmail.com) added the following:

- Added support for direct file reads directly into the cache.
- Report updated to display bytesize of directly read-in files.

Example usage:

<cfmodule template="/CustomTags/scopecache/scopecache.cfm" 
	cachename="content_123.gif" 
	scope="application" 
	timeout="#evaluate(60*60*24)#" 
	path="\\shared\dir\to\files\content_123.gif"
	isBinary="true"
	r_Data="binOutput" />

<cfheader name="Content-Disposition" value="inline; filename=content_123.gif">									
<cfcontent type="image/gif" variable="#binOutput#">

September 3, 2010: Added charset="utf-8", fix by Tobias Moos.
User norbs33 on RIAForge came up with 2 good updates. First he found a bug (http://scopecache.riaforge.org/index.cfm?event=page.issue&issueid=17C66403-F8A4-1019-4E24A6B8F46BD9D8)
and then he suggested a new feature - deffereddata (http://scopecache.riaforge.org/index.cfm?event=page.issue&issueid=18B8F072-F266-C5F5-291022DCC8CCE64F)

Both have been added.

January 21, 2010: Added charset="utf-8", fix by Tobias Moos.
