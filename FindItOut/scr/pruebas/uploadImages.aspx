<%@ Page Language="C#" AutoEventWireup="true" CodeFile="uploadImages.aspx.cs" Inherits="pruebas_uploadImages" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/jquery-1.11.1.js" type="text/javascript"></script>
    <script type="text/javascript" src="../Scripts/jquery.wallform.js"></script>
<script type="text/javascript">
    $(document).ready(function () {

       
        $('#photoimg').on('change', function () {
            //$("#preview").html('');

            $("#imageform").ajaxForm({ target: '#preview',
                beforeSubmit: function () {

                    //console.log('ttest');
                    $("#imageloadstatus").show();
                    $("#imageloadbutton").hide();
                },
                success: function (s) {
                    // console.log('test');
                    var d = new Date();
                    $("#preview").html("<img src='..\\img\\FindOut\\FindItOutName\\Item\\filename2.jpg?"+d.getTime()+"' />");
                    $("#imageloadstatus").hide();
                    $("#imageloadbutton").show();
                },
                error: function () {
                    // console.log('xtest');
                   
                    $("#imageloadstatus").hide();
                    $("#imageloadbutton").show();
                }
            }).submit();


        });
    });

    function addalgo() {

        $('#nombreee').html($('#nombreee').html()+'holaaaaa'); 
    }
</script>

    <style type="text/css">

body
{
font-family:arial;
}

#preview
{
color:#cc0000;
font-size:12px
}
.imgList 
{
max-height:150px;
margin-left:5px;
border:1px solid #dedede;
padding:4px;	
float:left;	
}

</style>
</head>
<body>
    <form  id="imageform" method="post" enctype="multipart/form-data" style="clear:both" action="uploadImages.aspx">
    <div id='preview'>
</div>

Upload image: 
<div id='imageloadstatus' style='display:none'><img src="../images/loader.gif" alt="Uploading...."/></div>
<div id='imageloadbutton' onclick="javascript:addalgo();">
<input type="file" name="photos[]" id="photoimg" multiple="true" runat="server" />
</div>

    <div>
    
    </div>
    <div id="nombreee">
    </div>
    <div id="respuesta" runat="server">
    </div>

    </form>
</body>
</html>
