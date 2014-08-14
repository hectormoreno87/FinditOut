<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageLogin.master" AutoEventWireup="true" CodeFile="frmSearch.aspx.cs" Inherits="search_frmSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDgswrmT3KpX1iyQjOjDq_G2LAP5cpz5KY&sensor=TRUE">
  </script>
  <script src="../Scripts/jquery-1.11.1.js" type="text/javascript"></script>

   <script type="text/javascript">

       $(function () {
           initialize();
       });
       function initialize() {
           var mapOptions = {
               center: new google.maps.LatLng(20.6827248, -103.3466798),
               zoom: 8,
               mapTypeId: google.maps.MapTypeId.SATELLITE
           };
           var map = new google.maps.Map(document.getElementById("map_canvas"),
            mapOptions);

           var marker = new google.maps.Marker({
               position: new google.maps.LatLng(20.6827248, -103.3466798),
               map: map,
               title: "JAJA que pendejos"
           });


       }


    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table width="100%" style="height:100%">
<tr>
<td style="width:25%" valign="top">
<table>
<tr>
    <td>
        <input id="search" type="text" />
    </td>
    <td>
        
    </td>

</tr>
<tr>
    <td>
    <div id="results">
    </div>
    </td>
</tr>

</table>


</td>
<td style="width:75%">
 <div id="map_canvas" style="width:100%; height:100%"></div>
</td>
</tr>
</table>

</asp:Content>

