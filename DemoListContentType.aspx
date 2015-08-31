<asp:Content ID="Main2" ContentPlaceHolderID="PlaceHolderMain" runat="server">
	<SharePoint:ScriptLink ID="ScriptLink1" Name="SP.js" runat="server" OnDemand="false" Localizable="false" LoadAfterUI="True"></SharePoint:ScriptLink>
	<script type='text/javascript'>
	(function() {
		var listContentTypes;
		var contentTypeName = "";
		var contentTypeParent;

   		function runCSOMCall() {

 	
    		var targetWeb;
			var list;
		    var ctx = new SP.ClientContext();
		    targetWeb = ctx.get_web();
		    list = targetWeb.get_lists(); 
		    targetList = list.getByTitle("Project Documents"); //get the list details
	
		    ctx.load(targetWeb);
		    ctx.load(targetList);
			listContentTypes = targetList.get_contentTypes();
    		ctx.load(listContentTypes);
    		//ctx.load(contentTypeParent);
		    ctx.executeQueryAsync(function(){
		 	
		 	var ct_enumerator = listContentTypes.getEnumerator();
		    while (ct_enumerator.moveNext()) {
		        var ct = ct_enumerator.get_current();
		             //we've got our content type, now let's get its name
		            contentTypeName += "Content types in this list: " +  ct.get_name()  + '\n';
		     }



			alert(contentTypeName);

		     var message = "List info :";
		     message += "\n list title: " + targetList.get_title();
				  //message += "\n list content types: " + targetList.get_contentTypes();
			$get('outputHtml').innerHTML = message;

			
		    }, function() {
			    $get('outputHtml').innerHTML = 'Request failed. \nError: ' + args.get_message() + '\nStackTrace: ' + args.get_stackTrace();
		    });
		}
	    window['runCSOMCall'] = runCSOMCall;
	})();
	_spBodyOnLoadFunctionNames.push("runCSOMCall");		 
	</script>
	<pre>
	<div id="outputHtml"/>
	</pre>
</asp:Content>


