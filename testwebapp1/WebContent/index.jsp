<!DOCTYPE html>
 <html lang="en">
 <head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/cupertino/jquery-ui.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.13.6/css/ui.jqgrid.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.13.6/js/jquery.jqgrid.min.js"></script>
  <title>Azure Test Web App </title>
</head>
<body>
  <div align="center" class="container" style="padding:50px 250px;">
    <h1>Azure Stack Test Web App</h1>
		<hr>
		<div align="left">
		<ul>
		<li>Jboss Community Edition - Wildfly 10.0</li> 
		<li>PostGres Database</li>
		<li>Rest Web Services</li>
		<li>SPA Architecture using JavaScript, JQuery</li>
		</ul>
		</div>
		<hr>
		<br>
	<table id="contacts" class="display" cellspacing="0" width="100%">
    </table>
	<div id="pager"></div>
  </div>
</body>
</html>
<script type="text/javascript">

 jQuery.extend(
        jQuery.jgrid.del, {
            ajaxDelOptions: { contentType: "application/json" },
            recreateForm: true,
            serializeDelData: function(postData) {
                console.log("In SerializeDelData: Serializing and Deletion of: ");
                console.log(postData);
                return JSON.stringify(postData);
            },
            afterSubmit: function (response, postdata) {
                console.log("In Jquery Extended Delete after Submit Function: ");
                console.log("------------------------------------");
                console.log("Response: ");
                console.log(response);
                console.log("Postdata: ");
                console.log(postdata);
               //var res = jQuery.parseJSON(response.responseText);
               //return [true, "", res.d];
                return [true, "", ""];
            }
        }
    );
jQuery.extend(
        jQuery.jgrid.edit, {
            ajaxEditOptions: { contentType: "application/json" },
            recreateForm: true,
            closeAfterAdd:true, closeAfterEdit:true, 
            serializeEditData: function(postData) {
                console.log("In SerializeEditData: Serializing and Create/Update of: ");
                console.log(postData);
                return JSON.stringify(postData);
            },
            afterSubmit: function (response, postdata) {
            console.log("In Jquery Extended Edit After Submit Function: ");
                console.log("------------------------------------");
                console.log("Response: ");
                console.log(response);
                console.log("Postdata: ");
                console.log(postdata);
               
               //var res = jQuery.parseJSON(response.responseText);
               //return [true, "", res.d];
                return [true, "", ""];
            }
        }
    );
 
$(document)
.ready(
        function() {
            $("#contacts")
                    .jqGrid(
                            {   editable: true,
                                url : 'http://localhost:8080/testwebapp/rest/service',
                                editurl : "http://localhost:8080/testwebapp/rest/service/controller",
                                datatype : 'json',
                                colNames : [ 'id', 'name', 'Last Name',
                                        'address'],
                                colModel : [ {
                                    name : 'id',
                                    index : 'contacts_id',
                                    width : 100,
                                    editable : false
                                }, 
                                {
                                    name : 'name',
                                    index : 'name',
                                    width : 250,
                                    editable : true
                                },{
                                    name : 'surname',
                                    index : 'surname',
                                    width : 250,
                                    editable : true
                                }, {
                                    name : 'address',
                                    index : 'address',
                                    width : 400,
                                    editable : true
                                } ],
                                pager : '#pager',
                                rowNum : 10,
                                rowList : [ 10, 20, 30 ],
                                sortname : 'contacts_id',
                                sortorder : 'asc',
                                viewrecords : true,
                                gridview : true,
                                caption : 'Contact Names and Addresses',
                                jsonReader : {
                                    repeatitems : false,
                                }                 
                            });
   $("#contacts").jqGrid('navGrid','#pager',
	{
		edit:true, edittitle: "Edit Contact", width: 500,
		add:true, addtitle: "Add Contact", width: 500,
		del:true,
		search: true,
		refresh: true,
		view:true
	},
    //Edit Options. save key parameter will keybind the Enter key to submit.
	{
		editCaption: "Edit Contact",
		edittext: "Edit",
		closeOnEscape: true,
		closeAfterAdd: true,
		closeAfterEdit: true,
		savekey: [true, 13],
		errorTextFormat: commonError,
		width: "500",
		reloadAfterSubmit: true,
		bottominfo: "Fields marked with (*) are required",
		top: "60",
		left: "5",
		right: "5",
		onclickSubmit: function (response, postdata) {
			//call edit button
			EditContact(postdata);
		}
	},
	//add Options. save key parameter will keybind the Enter key to submit.
	{
		addCaption: "Add Contact",
		addtext: "Add",
		closeOnEscape: true,
		closeAfterAdd: true,
		closeAfterEdit: true,
		savekey: [true, 13],
		errorTextFormat: commonError,
		width: "500",
		reloadAfterSubmit: true,
		bottominfo: "Fields marked with (*) are required",
		top: "60",
		left: "5",
		right: "5",
		onclickSubmit: function (response, postdata) {
			AddContact(postdata);
		}
	},
	//delete Options. save key parameter will keybind the Enter key to submit.
	{
		deleteCaption: "Delete Contact",
		deletetext: "Delete",
		closeOnEscape: true,
		closeAfterEdit: true,
		savekey: [true, 13],
		errorTextFormat: commonError,
		width: "500",
		reloadAfterSubmit: true,
		bottominfo: "Fields marked with (*) are required",
		top: "60",
		left: "5",
		right: "5",
		onclickSubmit: function (response, postdata) {
			DeleteContact(postdata);
		}
	}


	);
	function commonError(data) {
        return "Error Occured during Operation. Please try again";
    }
	function EditContact(params) {
		//Here you need to define ajax call for update records to server
		console.log(params);
	}
	function AddContact(params) {
		//Here you need to define ajax call for insert records to server
		console.log(params);
	}
	function DeleteContact(params) {
		//Here you need to define ajax call for delete records to server
		console.log(params);
	}
  });
</script>
</html>