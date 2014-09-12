<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterAdmin.master" AutoEventWireup="true" CodeFile="Catalog.aspx.cs" Inherits="Admin_Catalog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Myhead" Runat="Server">
    <link href="../css/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!--<link href="../css/jquery.fileupload-ui.css" rel="stylesheet" type="text/css" />-->
    <style type="text/css">
        #appMain .categoryHeader
        {
            height: 30px;
            width: 500px;
            background-color: gainsboro;
        }
        
        #appMain button
        {
            float: right;
        }
        
        #appMain .product
        {
            float: left;
            min-height: 0;
            height: 165px;
            width: 165px;
            text-align: center;
            /*padding: 92px 10px 0 10px;*/
            margin: 0 20px 30px 0;
            background-color: lightsteelblue;
        }
        
        #appMain .productImages
        {
            height: 80px;
            width: 165px;
            text-align: center;
            /*padding: 92px 10px 0 10px;*/
            /*margin: 0 20px 30px 0;*/
            background-color: lightsteelblue;
        }
       
        
    </style>    
    <script src="../scripts/libs/jquery/jquery-min.js"></script>
    <script type="text/javascript">
        var hdnUser, hdnCo;
        $(document).ready(function () {
            hdnUser = $('#<%= hdnUser.ClientID %>').val();
            hdnCo = $('#<%= hdnCo.ClientID %>').val();
        });
    </script>
    <script src="../scripts/libs/jquery/jquery-ui-min.js"></script>
    <script type="text/javascript" src="../scripts/libs/bootstrap/bootstrap.js"></script>
    <script type="text/javascript" data-main="../scripts/mainCatalog" src="../scripts/libs/require/require.js"></script>
    <!--<script src="../scripts/libs/fileupload/jquery.iframe-transport.js"></script>
    <script src="../scripts/libs/fileupload/jquery.fileupload.js"></script>
    <script src="../scripts/libs/fileupload/jquery.fileupload-ui.js"></script>-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="nestedContent" Runat="Server">
    <div id="appContainer" >
        
        <asp:HiddenField ID="hdnUser" runat="server" />
        <asp:HiddenField ID="hdnCo" runat="server" />
        
    </div>
</asp:Content>

