<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageLogin.master" AutoEventWireup="true" CodeFile="frmSearch.aspx.cs" Inherits="search_frmSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDgswrmT3KpX1iyQjOjDq_G2LAP5cpz5KY&sensor=TRUE">
  </script>
  <script src="../Scripts/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.bpopup.min.js" type="text/javascript"></script>
    <script src="../Scripts/richmarker.js" type="text/javascript"></script>
    <link href="../Styles/styleLogin.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/popUpStyle.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery.slides.min.js" type="text/javascript"></script>
    <link href="../Styles/styleToolTip.css" rel="stylesheet" type="text/css" />
    <link href="../css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    

    <style type="text/css">
    
    #itemResult
    {
    
    position:absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -30%);
        
   
    z-index: 9999;
    background-color: white;

        }

    #slides {
      display: none
    }

    #slides .slidesjs-navigation {
      margin-top:3px;
    }

    #slides .slidesjs-previous {
      margin-right: 5px;
      float: left;
    }

    #slides .slidesjs-next {
      margin-right: 5px;
      float: left;
    }

    .slidesjs-pagination {
      margin: 6px 0 0;
      float: right;
      list-style: none;
    }

    .slidesjs-pagination li {
      float: left;
      margin: 0 1px;
    }

    .slidesjs-pagination li a {
      display: block;
      width: 13px;
      height: 0;
      padding-top: 13px;
      background-image: url(../img/pagination.png);
      background-position: 0 0;
      float: left;
      overflow: hidden;
    }

    .slidesjs-pagination li a.active,
    .slidesjs-pagination li a:hover.active {
      background-position: 0 -13px
    }

    .slidesjs-pagination li a:hover {
      background-position: 0 -26px
    }

    #slides a:link,
    #slides a:visited {
      color: #333
    }

    #slides a:hover,
    #slides a:active {
      color: #9e2020
    }

    .navbar {
      overflow: hidden
    }
  </style>
  <!-- End SlidesJS Optional-->

  <!-- SlidesJS Required: These styles are required if you'd like a responsive slideshow -->
  <style>
    #slides {
      display: none
    }

    .container {
      margin: 0 auto
    }

    /* For tablets & smart phones */
    @media (max-width: 767px) {
      body {
        padding-left: 20px;
        padding-right: 20px;
      }
      .container {
        width: auto
      }
    }

    /* For smartphones */
    @media (max-width: 480px) {
      .container {
        width: auto
      }
    }

    /* For smaller displays like laptops */
    @media (min-width: 768px) and (max-width: 979px) {
      .container {
        width: 724px
      }
    }

    /* For larger displays */
    @media (min-width: 1200px) {
      .container {
        width: 1170px
      }
    }
  </style>

   <script type="text/javascript">



       function calcRoute() {
           var start = markerLocal.getPosition();
           var end = markObjetive.getPosition();
           

           var request = {
               origin: start,
               destination: end,
               waypoints: [],
               optimizeWaypoints: true,
               travelMode: google.maps.TravelMode.DRIVING
           };
           directionsService.route(request, function (response, status) {
               if (status == google.maps.DirectionsStatus.OK) {
                   directionsDisplay.setDirections(response);
                   var route = response.routes[0];
//                   var summaryPanel = document.getElementById('directions_panel');
//                   summaryPanel.innerHTML = '';
//                   // For each route, display summary information.
//                   for (var i = 0; i < route.legs.length; i++) {
//                       var routeSegment = i + 1;
//                       summaryPanel.innerHTML += '<b>Route Segment: ' + routeSegment + '</b><br>';
//                       summaryPanel.innerHTML += route.legs[i].start_address + ' to ';
//                       summaryPanel.innerHTML += route.legs[i].end_address + '<br>';
//                       summaryPanel.innerHTML += route.legs[i].distance.text + '<br><br>';
//                   }
               }
           });
       }



       $(function () {
           inicializaFacebok();

       });

       function inicializaFacebok() {
           window.fbAsyncInit = function () {
               FB.init({
                   appId: '772335249490789',
                   xfbml: true,
                   status: 0,
                   version: 'v2.1'
               });
           };

           (function (d, s, id) {
               var js, fjs = d.getElementsByTagName(s)[0];
               if (d.getElementById(id)) { return; }
               js = d.createElement(s); js.id = id;
               js.src = "//connect.facebook.net/es_LA/sdk.js";
               fjs.parentNode.insertBefore(js, fjs);
           } (document, 'script', 'facebook-jssdk'));

       }

       var windowheight ;
       var mapGlobal;
       var markerLocal;
       var mapOptionsGlobal;
       var populationOptions;
       var cityCircle;
       var infowindow;
       var markers = [];
       var items = [];
       var directionsDisplay;
       var directionsService = new google.maps.DirectionsService();
       var markObjetive;


       $(function () {
           windowheight = window.innerHeight;
           initialize();
           $('#load').hide();
           $('#results').css('height', $(window).height() * .67);
           $(window).resize(function () {
               windowheight = window.innerHeight;
               $('#results').css('height', $(window).height() * .67);
               $('.slidesjs-container').css('width', '500px');
               $('.slidesjs-control').css('width', '500px');
               $('.slidesjs-container').css('height', '430px !important');
               $('.slidesjs-control').css('height', '430px !important');
               //$("#log").append("<div>Handler for .resize() called.</div>");
           });

           $(window).change(function () {
               windowheight = window.innerHeight;
               $('#results').css('height', $(window).height() * .67);
               $('.slidesjs-container').css('width', '500px');
               $('.slidesjs-control').css('width', '500px');
               $('.slidesjs-container').css('height', '430px !important');
               $('.slidesjs-control').css('height', '430px !important');
               //$("#log").append("<div>Handler for .resize() called.</div>");
           });

           window.onscroll = func;

           $.ajaxSetup({ cache: false });
       });

       function func() {

           $('#content').css('top', window.pageYOffset);
           $('#content').css('height', windowheight);
           //$("#log").append("<div>Handler for .resize() called.</div>");
       };

      function initialize() {
          directionsDisplay = new google.maps.DirectionsRenderer();
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
           directionsDisplay.setMap(mapGlobal); 

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

       function showItemPopUp(idItem) {
           $('#load').show();
           $('#content').addClass('modalBackground');
           PageMethods.geTInfoItem(idItem, getInfoItemCallback);
       }

       function closePop() {
           $('#load').hide();
           $('#content').removeClass('modalBackground');
           $('#itemResult').html('');
       }

       var images = [];
       function getInfoItemCallback(sRes) {

           $('#load').hide();
           var infoItem = eval(sRes)[0];

           $.get("../utils/htmlPopUp/item.html", function (respons) {

               respons = respons.replace('@logo@', infoItem.logo);
               respons = respons.replace('@company@', '<h1>' + infoItem.finditoutName + '</h1>');
               images = infoItem.images.split("@@");
               var divImages = '';
               var counter = 0;
               $.each(images, function (key, value) {
                   //if (counter == 0)
                   divImages = divImages + '<img id="_' + key + '" src="' + value + '" style="width:500px !important; height:430px !important" ></img>';
                   //else
                   //    divImages = divImages + '<img id="_' + key + '" src="' + value + '" style="display:none"></img>';
                   counter = counter + 1;
               });

               respons = respons.replace('@images@', divImages);
               respons = respons.replace('@producto@', '<h1>' + infoItem.name + '</h1>');
               respons = respons.replace('@description@', infoItem.description);
               respons = respons.replace('@pluginFace@',  '<div  class="fb-like"  data-send="true"  data-width="430"  data-show-faces="true" data-href="http://www.google.com"></div>');


               var divphones = '';
               var phones = infoItem.phones.split("@");
               $.each(phones, function (key, value) {
                   //if (counter == 0)
                   divphones = divphones + '<a>' + value + ' </a>|';
                   //else
                   //    divImages = divImages + '<img id="_' + key + '" src="' + value + '" style="display:none"></img>';
                   counter = counter + 1;
               });


               respons = respons.replace('@phones@', divphones);


               var divsaps = '';
               var wats = infoItem.whatsaps.split("@");
               $.each(wats, function (key, value) {
                   //if (counter == 0)
                   divsaps = divsaps + '<a>' + value + ' </a>|';
                   //else
                   //    divImages = divImages + '<img id="_' + key + '" src="' + value + '" style="display:none"></img>';
                   counter = counter + 1;
               });


               respons = respons.replace('@whatsapp@', divsaps);
               respons = respons.replace('@face@', infoItem.facebook);
               respons = respons.replace('@twitter@', infoItem.twitter);
               $('#itemResult').html(respons);

               $('#slides').slidesjs({
                   navigation: false
                   

               });
               $('.slidesjs-container').css('width', '500px');
               $('.slidesjs-control').css('width', '500px');
               $('.slidesjs-container').css('height', '430px');
               $('.slidesjs-control').css('height', '430px');

               FB.XFBML.parse();

           });

           

       }
     

       function makeInfoWindowEvent(map, infowindow, contentString, marker) {
           google.maps.event.addListener(marker, 'click', function () {
               infowindow.setContent(contentString);
               infowindow.open(map, marker);
               makeInfoWindowEvent
               markObjetive = marker;
           });
       }

       function makeInfoWindowEventFromDiv(map, infowindow, contentString, marker) {
           
               infowindow.setContent(contentString);
               infowindow.open(map, marker);
               markObjetive = marker;
           
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

       function divSelected(id, index) {
           $('#map_canvas').animate({ height: ($(window).height() * .67)+'px' },1000);
           $('#divBack').html('');
           $('#divBack').animate({ height: "0%" }, 1000);
           $('#divCompany').html('');
           $('#divCompany').animate({ height: "0%" }, 1000);

           $.each(markers, function (index, value) {
               if (value.id == id) {
                   //markObjetive = value.mark;

                   mapGlobal.setCenter(value.mark.getPosition());
                   $(".itemDivSelected").removeClass().addClass("itemDiv");
                   $("#div" + items[index].idItem).removeClass().addClass("itemDivSelected");
                   makeInfoWindowEventFromDiv(mapGlobal, infowindow, getHtmlpop(items[index]), value.mark);

                   //value.mark.setContent(value.mark.getContent().replace('h3','h2'));

               }

           });
       }


       function showCompany(idI) {
           PageMethods.getCompany(idI, getCompanyCallback);

     }

     function getCompanyCallback(sResult) {
         $('#map_canvas').animate({ height: "0%" }, 1000);
         $('#divBack').animate({ height: "5%" }, 1000);
         $('#divBack').html('Volver a Producto');
         $('#divCompany').html(sResult).animate({ height: "95%" }, 1000);
     }

     function backToProduct(idI) {
         $('#map_canvas').animate({ height: ($(window).height() * .67) + 'px' }, 1000);
         $('#divBack').html('');
         $('#divBack').animate({ height: "0%" }, 1000);
         $('#divCompany').html('');
         $('#divCompany').animate({ height: "0%" }, 1000);

     }

     function getInfoSucursal() {
         var s = $('#idSucursal').val();
         PageMethods.getInfoSucursal(s, callbackGetSucursal);


      }

      function callbackGetSucursal(sRes) {
          $('#datosSucursal').html(sRes); 
      }

       function searchfCallback(sResult) {
          infowindow = new google.maps.InfoWindow();

           markers = [];
           items = eval(sResult);
           var st = "<table width='100%'>";
           $.each(items, function (index, value) {
               st += "<tr>";
               st += "<td>";
               st += "<div id='div" + value.idItem + "' class=\"itemDiv\" onclick='javascript:divSelected(" + value.idItem + "," + index + ")'>";
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


       function getRoute() {
           calcRoute();

       }

       function getHtmlpop(value) {
          // markObjetive = value;

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

           st += "<td>";
           st += "<div id='divRoute' style='border-width: 2px;border-style: solid;' onclick='javascript:getRoute();'>";
           st += "<img alt='" + value.name + "' src='../images/map-route-icon.png' width='30px' height='30px'  tittle='Route'/>";
           st += "<div id='divRouteToolTip' >";
           st += "Route";
           st += "</div>";
           st += "</div>";
           
           st += "</td>";

           st += "</tr>";
           st += "<tr>";
           st += "<td>";
           st += "<div ><a onclick=\"javascript:showItemPopUp(" + value.idItem + ")\">Detalles</a></div>";
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
           st += "<div ><a href='#'><span onclick='javascript:showCompany("+value.idItem+");'>"+value.finditoutName+"</span></a></div>";
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
    <div id="results" style="overflow: scroll;" >
    </div>
    </td>
</tr>

</table>


</td>
<td style="width:100%">
 <div id="map_canvas" style="width:100%; height:100%;"></div>
 <div id="divBack" style="width:100%; height:0%;" onclick="javascript:backToProduct(1);">Volver a Producto</div>
 <div id="divCompany" style="width:100%; height:0%;"></div>
</td>
</tr>
</table>

<div id="content" style="display:none">


<%--<table>
<tr>
    <td>
        
    </td>
</tr>
<tr>
    <td>
        <input id="btnSaveLocation" type="button" value="OK" onclick="javascript:setLocation();" />
    </td>
</tr>
</table>--%>


</div>
<div id="itemResult">

</div>



</asp:Content>

