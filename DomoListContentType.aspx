<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Inherits="System.Web.UI.Page" MasterPageFile="~masterurl/default.master" Title="CSOM Demo" meta:progid="SharePoint.WebPartPage.Document"%>
<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
	<SharePoint:ScriptLink ID="ScriptLink1" Name="SP.js" runat="server" OnDemand="false" Localizable="false" LoadAfterUI="True"></SharePoint:ScriptLink>
	<script type='text/javascript'>
	(function() {
   		function runCSOMCall() {
			
			var listContentTypes;
    		var targetWeb;
			var list;
		    var ctx = new SP.ClientContext();
		    targetWeb = ctx.get_web();
		    list = targetWeb.get_lists(); 
		    targetList = list.getByTitle("DocumentTemplates"); //get the list details
			
			this.listContentTypes = targetList.get_contentTypes(); //WHY THIS is Undefined?


		    ctx.load(targetWeb);
		    ctx.load(targetList);
		    ctx.load(this.listContentTypes);

		    ctx.executeQueryAsync(function(){

		     var message = "List info :";
		

				  message += "\n list title: " + targetList.get_title();
				  //message += "\n list content types: " + targetList.get_contentTypes();

			var contentTypeinfo = '';
		    var contentTypeEnumerator = this.listContentTypes.getEnumerator(); //ERROR: Unable to get property 'getEnumerator' of undefined or null reference 


		    while (contentTypeEnumerator.moveNext()) {
		        var content = contentTypeEnumerator.get_current();
		        contentTypeinfo += 'Content Type Name: ' + content.get_name() + '\n';
		    }
		    consloe.log(contentTypeinfo);

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

<asp:Content ID="Main2" ContentPlaceHolderID="PlaceHolderMain" runat="server">
	<SharePoint:ScriptLink ID="ScriptLink1" Name="SP.js" runat="server" OnDemand="false" Localizable="false" LoadAfterUI="True"></SharePoint:ScriptLink>
	<script type='text/javascript'>
	(function() {
		var context;
		var listContentTypes;
		var contentTypeName = "";

   		function runCSOMCall() {

   			  context = SP.ClientContext.get_current();
			
    		var targetWeb;
			var list;
		    var ctx = new SP.ClientContext();
		    targetWeb = ctx.get_web();
		    list = targetWeb.get_lists(); 
		    targetList = list.getByTitle("DocumentTemplates"); //get the list details
		    contentTypeUrl = //?????????????????????????????
		    contentTypeParent//?????????????????????????????
		    ctx.load(targetWeb);
		    ctx.load(targetList);
			listContentTypes = targetList.get_contentTypes();
    		ctx.load(listContentTypes);
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


