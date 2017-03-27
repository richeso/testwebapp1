<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>CH Testing Azure Stack with Jboss Community and Postgres DB</title>
 
<link rel="stylesheet" type="text/css" media="screen" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/themes/base/jquery-ui.css" />
<link rel="stylesheet" type="text/css" media="screen" href="http://trirand.com/blog/jqgrid/themes/ui.jqgrid.css" />
  
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
 
<script src="http://trirand.com/blog/jqgrid/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="http://trirand.com/blog/jqgrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script type="text/javascript">
jQuery.extend(
        jQuery.jgrid.edit, {
            ajaxEditOptions: { contentType: "application/json" },
            recreateForm: true,
            serializeEditData: function(postData) {
                return JSON.stringify(postData);
            },
            afterSubmit: function (response, postdata) {
                var res = jQuery.parseJSON(response.responseText);
                return [true, "", res.d];
            }
        }
    );
 
$(document)
.ready(
        function() {
            $("#list")
                    .jqGrid(
                            {
                                url : 'http://localhost:8080/testwebapp/rest/service',
                                datatype : 'json',
                                mtype : 'GET',
                                colNames : [ 'name', 'Last Name',
                                        'address'],
                                colModel : [ {
                                    name : 'name',
                                    index : 'name',
                                    width : 150,
                                    editable : true
                                }, {
                                    name : 'surname',
                                    index : 'surname',
                                    width : 150,
                                    editable : true
                                }, {
                                    name : 'address',
                                    index : 'address',
                                    width : 200,
                                    editable : true
                                } ],
                                pager : '#pager',
                                rowNum : 10,
                                rowList : [ 10, 20, 30 ],
                                sortname : 'invid',
                                sortorder : 'desc',
                                viewrecords : true,
                                gridview : true,
                                caption : 'Data Report',
                                jsonReader : {
                                    repeatitems : false,
                                },
                                editurl : "http://localhost:8080/testwebapp/rest/service/controller",
                                datatype : 'json'
                            });
            jQuery("#list").jqGrid('navGrid', '#pager', {
                edit : true,
                add : true,
                del : true,
                search : true
            });
        });
    
</script>
</head>

<div align="center">
<h1> CH Azure Test Web App</h1>
<hr>
<div align="left">
<ul>
<li>Jboss Community Edition - Wildfly 10.0</li> 
<li>PostGres Database</li>
<li>Rest Web Services</li>
<li>SPA Architecture using JavaScript, Angular.js, JQuery</li>
</ul>
</div>
<hr>
<body>
    <table id="list">
        <tr>
            <td />
        </tr>
    </table>
    <div id="pager"></div>
</body>
</div>
</html>