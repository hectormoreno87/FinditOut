<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageLogin.master" AutoEventWireup="true" CodeFile="frmSearch.aspx.cs" Inherits="search_frmSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDgswrmT3KpX1iyQjOjDq_G2LAP5cpz5KY&sensor=TRUE">
  </script>
  <script src="../Scripts/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.bpopup.min.js" type="text/javascript"></script>
    <script src="../Scripts/richmarker.js" type="text/javascript"></script>
    <link href="../Styles/styleLogin.css" rel="stylesheet" type="text/css" />
   <script type="text/javascript">

       var mapGlobal;
       var markerLocal;
       var mapOptionsGlobal;
       var populationOptions;
       var cityCircle;
       var infowindow;
       var markers = [];
       var items = [];
       $(function () {
          initialize();
      });

      function initialize() {

          mapOptionsGlobal = {
               center: new google.maps.LatLng(20.6827248, -103.3466798),
               zoom: 14,
               mapTypeId: google.maps.MapTypeId.ROADMAP 
           };
           mapGlobal = new google.maps.Map(document.getElementById("map_canvas"),
            mapOptionsGlobal);

           markerLocal = new google.maps.Marker({
               position: new google.maps.LatLng(20.6827248, -103.3466798),
               map: mapGlobal,
               draggable: true,
               title: "Mi posición"
           });

           populationOptions = {
               strokeColor: '#FFFF00',
               strokeOpacity: 0.8,
               strokeWeight: 2,
               fillColor: '#FFFF00',
               fillOpacity: 0.35,
               map: mapGlobal,
               center: markerLocal.getPosition(),
               radius:parseInt($('#ddlDistance').val())
           };
           // Add the circle for this city to the map.
           cityCircle = new google.maps.Circle(populationOptions);
           getLocation();

           google.maps.event.addListener(markerLocal, 'drag', function (event) {
               $("#error").html('Latitude:' + event.latLng.lat() + ', Longitude:' + event.latLng.lng());
               cityCircle.setCenter(markerLocal.getPosition());
               cityCircle.setRadius(parseInt($('#ddlDistance').val()));

               //new google.maps.Circle(populationOptions);
           });

           google.maps.event.addListener(markerLocal, 'dragend', function (event) {
               $("#error").html('Latitude:' + event.latLng.lat() + ', Longitude:' + event.latLng.lng());
               cityCircle.setCenter(markerLocal.getPosition());
               cityCircle.setRadius(parseInt($('#ddlDistance').val()));
               //new google.maps.Circle(populationOptions);

           });

       }

       var x = document.getElementById("error");
       function getLocation() {
           if (navigator.geolocation) {
               navigator.geolocation.getCurrentPosition(showPosition, showError);
           }
           else {
               x.innerHTML = "Geolocation is not supported by this browser.";
           }
       }
       function showPosition(position) {
           var latlondata = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);

           
           mapGlobal.setCenter(latlondata);


           markerLocal.setPosition(latlondata);
           cityCircle.setCenter(markerLocal.getPosition());
           cityCircle.setRadius(parseInt($('#ddlDistance').val()));
           $("#error").html('Latitude:' + position.coords.latitude + ', Longitude:' + position.coords.longitude);


       }

       function makeInfoWindowEvent(map, infowindow, contentString, marker) {
           google.maps.event.addListener(marker, 'click', function () {
               infowindow.setContent(contentString);
               infowindow.open(map, marker);
           });
       }

       function makeInfoWindowEventFromDiv(map, infowindow, contentString, marker) {
           
               infowindow.setContent(contentString);
               infowindow.open(map, marker);
           
       }

       function showError(error) {
           if (error.code == 1) {
               x.innerHTML = "User denied the request for Geolocation."
           }
           else if (err.code == 2) {
               x.innerHTML = "Location information is unavailable."
           }
           else if (err.code == 3) {
               x.innerHTML = "The request to get user location timed out."
           }
           else {
               x.innerHTML = "An unknown error occurred."
           }
       }


       function setRadious() {
           cityCircle.setRadius(parseInt($('#ddlDistance').val()));
           //$("#content").bPopup().close();
       }

       function searchf() {
           PageMethods.searchM(markerLocal.getPosition(), $('#search').val(), parseInt($('#ddlDistance').val()), searchfCallback);
       }

       function divSelected(id,index) {

           $.each(markers, function (index, value) {
               if (value.id == id) {

                   

                   mapGlobal.setCenter(value.mark.getPosition());
                   $(".itemDivSelected").removeClass().addClass("itemDiv");
                   $("#div" + items[index].idItem).removeClass().addClass("itemDivSelected");
                   makeInfoWindowEventFromDiv(mapGlobal, infowindow, getHtmlpop(items[index]), value.mark);
                   //value.mark.setContent(value.mark.getContent().replace('h3','h2'));
                   
               }

           });
       }

       function searchfCallback(sResult) {
          infowindow = new google.maps.InfoWindow();

           markers = [];
           items = eval(sResult);
           var st = "<table width='100%'>";
           $.each(items, function (index, value) {
               st += "<tr>";
               st += "<td>";
               st += "<div id='div" + value.idItem + "' class=\"itemDiv\" onclick='javascript:divSelected(" + value.idItem + ","+index+")'>";
               st += "<table>";
               st += "<tr>";
               st += "<td>";
               st += "<h1>" + (index + 1) + "</h1>";
               st += "</td>";
               st += "<td>";
               st += "<img alt='" + value.name + "' src='" + value.image + "' width='55px' height='55px'/>";
               st += "</td>";
               st += "<td>";
               st += "<table>";
               st += "<tr>";
               st += "<td>";
               st += "<img alt='" + value.finditoutName + "' src='" + value.logo + "' width='20px' height='20px'/>";
               st += value.finditoutName;
               st += "</td>";
               st += "</tr>";
               st += "<tr>";
               st += "<td>";
               st += "<h3>";
               st += value.name;
               st += "</h3>";
               st += "</td>";
               st += "</tr>";
               st += "<tr>";
               st += "<td>";

               st += value.distance;

               st += "</td>";
               st += "</tr>";
               st += "<tr>";
               st += "<td>";

               st += '$ ' + value.cost;

               st += "</td>";
               st += "</tr>";

               st += "</table>";


               st += "</td>";
               st += "</tr>";
               st += "</table>";

               st += "</div>";
               st += "<td>";
               st += "</tr>";


               var marker = new RichMarker({
                   position: new google.maps.LatLng(parseFloat(value.latitude), parseFloat(value.longitude)),
                   map: mapGlobal,
                   draggable: false,

                   title: value.name,
                   shadow: false,
                   content: '<div class="mark"><table><tr><td align="center" ><h3 style="color: white;margin: 7px;margin-right: 10px;">' + (index + 1) + '</h3></td></tr></table></div>' //'<div class="mark"><table><tr><td>'+(index + 1)+'<img alt="' + value.name + '" src="' + value.image + '" width="25px" height="25px"/></td><td>' + value.name + '</td></tr> <tr><td>$ ' + value.cost + '</td> <td> <a href="#">detalles</a></td></tr></table></div>'            
               });

               var marker_ = { id: value.idItem, mark: marker };

               makeInfoWindowEvent(mapGlobal, infowindow, getHtmlpop(value), marker);
               google.maps.event.addListener(marker, 'click', function () {

                   mapGlobal.setCenter(marker.getPosition());
                   $(".itemDivSelected").removeClass().addClass("itemDiv"); 
                   $("#div" + value.idItem).removeClass().addClass("itemDivSelected"); 
               });

               markers.push(marker_);

           });
           st += "</table>";
           $('#results').html(st);
       }

       function getHtmlpop(value) {
          var  st = "<table>";
           st += "<tr>";
           st += "<td>";
           st += "<img alt='" + value.name + "' src='" + value.image + "' width='75px' height='75px'/>";
           st += "</td>";
           st += "<td>";
           st += "<table>";
//           st += "<tr>";
//           st += "<td>";
//           st += "<img alt='" + value.finditoutName + "' src='" + value.logo + "' width='20px' height='20px'/>";
//           st += value.finditoutName;
//           st += "</td>";
//           st += "</tr>";
           st += "<tr>";
           st += "<td>";
           st += "<h3>";
           st += value.name;
           st += "</h3>";
           st += "</td>";
           st += "</tr>";
           st += "<tr>";
           st += "<td>";

           st += "<div >"+value.description+"</div>";

           st += "</td>";
           st += "</tr>";
           st += "<tr>";
           st += "<td>";

           st += "<div ><a href='#'>Detalles</a></div>";

           st += "</td>";
           st += "</tr>";
           st += "<tr>";
           st += "<td>";

           st += value.distance;

           st += "</td>";
           st += "</tr>";
           st += "<tr>";
           st += "<td>";

           st += '$ ' + value.cost;

           st += "</td>";
           st += "</tr>";
           st += "<tr>";
           st += "<td>";

           st += "<div ><a href='#'>"+value.finditoutName+"</a></div>";

           st += "</td>";
           st += "</tr>";
           st += "</table>";


           st += "</td>";
           st += "</tr>";

           st += "</table>";

           return st;
       }

    </script>
    <script src="../Scripts/geoLocation.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table width="100%" style="height:100%">
<tr>
<td style="width:25%" valign="top">
<table>
<tr>
    <td>
        <input id="search" type="text" class="cajaLarga" />
    </td>
    <td>
       <img src="../images/searchimage.png" width="30px" height="30px" onclick="javascript:searchf();" style="cursor:pointer" alt="buscar" />
    </td>
</tr>
<tr>
<td>
<%--<a class="link">

    <asp:Label ID="Label1" runat="server"   Text='<%$ Resources:Globalresource, setLocation %>' onclick="javascript:searchf();"></asp:Label>
</a>
|--%> <a class="link">

    <asp:Label ID="Label2" runat="server"   Text='<%$ Resources:Globalresource, setLocalLocation %>' onclick="javascript:getLocation();"></asp:Label>
</a>
</td>
</tr>
<tr>
<td>
  <asp:Label ID="Label1" runat="server"   Text='<%$ Resources:Globalresource, distance %>' ></asp:Label>
    <select id="ddlDistance" onchange="javascript:setRadious();">
        <option value="100">100 m</option>
        <option value="200">200 m</option>
        <option value="500">500 m</option>
        <option value="700">700 m</option>
        <option value="1000" selected="selected">1 km</option>
        <option value="2000">2 km</option>
        <option value="5000">5 km</option>
        <option value="10000">10 km</option>
        <option value="20000">20 km</option>
        <option value="50000">50 km</option>
        <option value="100000">100 km</option>
    </select>
</td>
</tr>
<tr>
<td>
    <div id="error">
    Buscando..
    </div>
</td>
</tr>
<tr>
    <td>
    <div id="results" style="overflow: scroll;">
    </div>
    </td>
</tr>

</table>


</td>
<td style="width:75%">
 <div id="map_canvas" style="width:100%; height:100%;"></div>
</td>
</tr>
</table>

<div id="content" style="width:500px;height:500px;display:none">



<table style="width:100%;height:100%">
<tr>
    <td>
        <div id="mapLocation" style="width:100%;height:100%">
        </div>
    </td>
</tr>
<tr>
    <td>
        <input id="btnSaveLocation" type="button" value="OK" onclick="javascript:setLocation();" />
    </td>
</tr>
</table>


</div>
</asp:Content>

