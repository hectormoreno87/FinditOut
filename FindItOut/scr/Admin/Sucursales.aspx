<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterAdmin.master" AutoEventWireup="true"  EnableSessionState="True"
    CodeFile="Sucursales.aspx.cs" Inherits="Admin_Sucursales" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Myhead" runat="Server">
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?libraries=places&region=uk&language=es&&key=AIzaSyDgswrmT3KpX1iyQjOjDq_G2LAP5cpz5KY&sensor=TRUE">
    </script>
    <script src="../Scripts/richmarker.js" type="text/javascript"></script>
    <script src="../Scripts/Validaciones.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="../Scripts/alertify.min.js" type="text/javascript"></script>
    <%--<script type="text/javascript" src="../Scripts/jquery.wallform.js"></script>--%>
    <script src="../Scripts/jquery.form.js" type="text/javascript"></script>
    <link href="../Styles/jquery.mCustomScrollbar.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery.mCustomScrollbar.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.mCustomScrollbar.concat.min.js" type="text/javascript"></script>

    <link href="../Styles/buttonStyles.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">

        var mapGlobal;
        var markerLocal;
        var mapOptionsGlobal;
        var populationOptions;
        var infowindow = new google.maps.InfoWindow();
        $(function () {
            initialize();
            $.ajaxSetup({ cache: false });
            loadInfoAfter();
            $("#preview").mCustomScrollbar();

        });

        function initialize() {
            mapOptionsGlobal = {
                center: new google.maps.LatLng(20.6827248, -103.3466798),
                zoom: 14,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            //aqui se crea el mapa
            mapGlobal = new google.maps.Map(document.getElementById("map_canvas"),
            mapOptionsGlobal);

            markerLocal = new google.maps.Marker({
                position: new google.maps.LatLng(20.6827248, -103.3466798),
                map: mapGlobal,
                draggable: true,
                title: "Mi posición"
            });

            

            getLocation();

            google.maps.event.addListener(markerLocal, 'drag', function (event) {
                //$("#posicion").html('Latitude:' + event.latLng.lat() + ', Longitude:' + event.latLng.lng());
                $("#<%=lblLatitud.ClientID%>").text(event.latLng.lat());
                $("#inputLatitud").val(event.latLng.lat());
                $("#<%=lblLongitud.ClientID%>").text(event.latLng.lng());
                $("#inputLongitud").val(event.latLng.lng());
            });

            google.maps.event.addListener(markerLocal, 'dragend', function (event) {
                //$("#posicion").html('Latitude:' + event.latLng.lat() + ', Longitude:' + event.latLng.lng());
                $("#<%=lblLatitud.ClientID%>").text(event.latLng.lat());
                $("#inputLatitud").val(event.latLng.lat());
                $("#<%=lblLongitud.ClientID%>").text(event.latLng.lng());
                $("#inputLongitud").val(event.latLng.lng());
            });

            ////////aqui está el autocomplete
            var input = document.getElementById('searchTextField');
            var autocomplete = new google.maps.places.Autocomplete(input, {
                types: ["establishment"]

            });

            autocomplete.bindTo('bounds', mapGlobal);


            google.maps.event.addListener(autocomplete, 'place_changed', function () {
                infowindow.close();
                var place = autocomplete.getPlace();
                if (place.geometry.viewport) {
                    mapGlobal.fitBounds(place.geometry.viewport);
                } else {
                    mapGlobal.setCenter(place.geometry.location);
                    mapGlobal.setZoom(17);
                }

                moveMarker(place.name, place.geometry.location);
            });

            $("input").focusin(function () {
                $(document).keypress(function (e) {
                    if (e.which == 13) {
                        infowindow.close();
                        var firstResult = $(".pac-container .pac-item:first").text();

                        var geocoder = new google.maps.Geocoder();
                        geocoder.geocode({ "address": firstResult }, function (results, status) {
                            if (status == google.maps.GeocoderStatus.OK) {
                                var lat = results[0].geometry.location.lat(),
                            lng = results[0].geometry.location.lng(),
                            placeName = results[0].address_components[0].long_name,
                            latlng = new google.maps.LatLng(lat, lng);
                                $("#<%=lblLatitud.ClientID%>").text(lat);
                                $("#<%=lblLongitud.ClientID%>").text(lng);
                                $("#inputLatitud").val(lat);
                                $("#inputLongitud").val(lng);
                                moveMarker(placeName, latlng);
                                //$("input").val(firstResult);
                            }
                        });
                    }
                });
            });



            ///aquí termina el autocomplete
        }

        function moveMarker(placeName, latlng) {
            var image = 'http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png';
            markerLocal.setIcon(image);
            markerLocal.setPosition(latlng);
            $("#<%=lblLatitud.ClientID%>").text(latlng.lat());
            $("#<%=lblLongitud.ClientID%>").text(latlng.lng());

            $("#inputLatitud").val(latlng.lat());
            $("#inputLongitud").val(latlng.lng());

            infowindow.setContent(placeName);
            infowindow.open(mapGlobal, markerLocal);
        }

        var x = document.getElementById("posicion");
        function getLocation() {

            if ($("#<%=idSuc.ClientID%>").val() == "") {
                $("#divImages").hide();
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(showPosition, showError);
                }
                else {
                    x.innerHTML = "Geolocation is not supported by this browser.";
                }
            }
            else {
                setmap();
            }

            



        }
        function showPosition(position) {
            var latlondata = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
            mapGlobal.setCenter(latlondata);
            markerLocal.setPosition(latlondata);
            //$("#posicion").html('Latitude:' + position.coords.latitude + ', Longitude:' + position.coords.longitude);
            $("#<%=lblLatitud.ClientID%>").text(position.coords.latitude);
            $("#<%=lblLongitud.ClientID%>").text(position.coords.longitude);

            $("#inputLatitud").val(position.coords.latitude);
            $("#inputLongitud").val(position.coords.longitude);

            


        }

        var images = [];
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
            else if (error.code == 2) {
                x.innerHTML = "Location information is unavailable."
            }
            else if (err.code == 3) {
                x.innerHTML = "The request to get user location timed out."
            }
            else {
                x.innerHTML = "An unknown error occurred."
            }
        }




    </script>

     <script type="text/javascript">
         function loadInfoAfter(){


             limpiaMensajes();
             

             $("#<%=photoimg.ClientID%>").on('change', function () {

                 $("#image").val(1);
                 $("#form1").ajaxForm({ target: '#preview',
                     dataType: 'json',
                     data: { IMAGEN: 1 },
                     type: "POST",
                     beforeSubmit: function () {
                         //console.log('ttest');
                         $("#imageloadstatus").show();

                         //$("#imageloadbutton").hide();
                         return;
                     },
                     success: function (s) {
                         $("#form1").ajaxFormUnbind();
                         //$("#preview").html("");
                         $("#preview").html(s.Data);
                         $("#imageloadstatus").hide();
                         $(".content").mCustomScrollbar({ axis: "yx" });
                         $("#image").val(0);
                         mensajeServidor(1, 'Cambios guardados con éxito');
                         // $("#imageloadbutton").show();
                         //cargaImagenes();
                     },
                     error: function (s, i, o) {
                         // console.log('xtest');      
                         $("#form1").ajaxFormUnbind();
                         if (s.Data) {

                             // $("#imageloadbutton").show();
                             var label = '<%=GetGlobalResourceObject("Globalresource", "lbl_NoMasImgs" ) %> ';
                             $("#preview").html("");
                             alertify.error(label);
                         }
                         else {
                             mensajeServidor(1, 'Cambios guardados con éxito');
                         }
                         $("#imageloadstatus").hide();

                         $("#image").val(0);
                     }
                 }).submit();

             });


             if ($("#<%=idSuc.ClientID%>").val() == "") {
                 $("#divImages").hide();
                 $("#<%=eliminar.ClientID%>").css("display", "none");

             }
             else {
                 $("#<%=eliminar.ClientID%>").css("display", "block");
                 setmap();
                 loadImages();
             }



             loadTels();
          
             if ($('#<%=typeofload.ClientID %>').val() == '0') {

                 mensajeServidor(1, 'Sucursal eliminada con éxito');
             }
             else if ($('#<%=typeofload.ClientID %>').val() == '1') {

                 mensajeServidor(1, 'Sucursal guardada con éxito');
             }
             

           


         }


         function loadImages() {

             PageMethods.cargaImagenes($("#<%=idSuc.ClientID%>").val(), callBackCargaImagenes);


         }

         function callBackCargaImagenes(sResult) 
         {

             $('#preview').html(sResult);

         }

         function setmap() {

             var lat = parseFloat($("#<%=lblLatitud.ClientID%>").text());
             var lng = parseFloat($("#<%=lblLongitud.ClientID%>").text());
             $("#inputLatitud").val($("#<%=lblLatitud.ClientID%>").text());
             $("#inputLongitud").val($("#<%=lblLongitud.ClientID%>").text());
             

             var placeName = $("#<%=txtNomSuc.ClientID%>").val(),
                       latlng = new google.maps.LatLng(lat, lng);
             moveMarker(placeName, latlng);
             mapGlobal.setCenter(latlng);
             
            $("#searchTextField").val($("#<%=placeNameHidden.ClientID%>").val());
             
         }



         function loadRedSocial() {

             PageMethods.cargaRedesSocialesWM($("#<%=idSuc.ClientID%>").val(), callBackCargaRedes);

         }

         function callBackCargaRedes(cadena) {
             $("#<%= div_redesS.ClientID %>").html('');
             $("#<%= div_redesS.ClientID %>").html(cadena);
             toolTip();
         }

         function loadTels() {

             PageMethods.getPhones($("#<%=idSuc.ClientID%>").val(), callBackGetPhones);

         }



         function callBackGetPhones(sResult) {
             var data = (eval(sResult)[0]).data;
             $("#divTelefonos").html(data);
             $('#idCountphones').val((eval(sResult)[0]).count);
             loadRedSocial();
            
         }



         
         function callBackSacaImagenes(carpeta) {
             var logo = "" + carpeta + "";
             $("#imageloadstatus").hide();
             //$("#imageloadbutton").show();
             var d = new Date();
             //$("#preview").html("<img src='..\\EmpresasFiles\\" + logo + "?" + d.getTime() + "' />");
             $(".cargaLogo").show();
         }

         function limpiaMensajes() {
             $(".errorPeque").hide();
         }

         function toolTip() {
             
             $('.masterTooltip').hover(function () {
                 // Hover over code
                 var title = $(this).attr('title');
                 $(this).find('p').remove();
                 $(this).data('tipText', title).removeAttr('title');

                 $('<p class="tooltip"></p>')
                .text(title)
                .appendTo('body')
                .fadeIn('slow');
             }, function () {
                 // Hover out code
                 $(this).attr('title', $(this).data('tipText'));
                 $('.tooltip').remove();
             }).mousemove(function (e) {
                 var mousex = e.pageX + 20; //Get X coordinates
                 var mousey = e.pageY + 10; //Get Y coordinates
                 $('.tooltip')
                .css({ top: mousey, left: mousex })
             });
         }

         function validarControl() {

             limpiaMensajes();

             var errores = 0;
             var suc = $("#<%=txtNomSuc.ClientID%>").val();
             var dir = $("#<%=txtDom.ClientID%>").val();
             var lat = $("#<%=lblLatitud.ClientID%>").text();
             var long = $("#<%=lblLongitud.ClientID%>").text();

             if (validarVacio(suc)) {
                 $("#<%=lblSucPon.ClientID%>").hide();
             } else {
                 $("#<%=lblSucPon.ClientID%>").show();
                 errores = 1;
             }

             if (validarVacio(dir)) {
                 $("#<%=lblDirPon.ClientID%>").hide();
             } else {
                 $("#<%=lblDirPon.ClientID%>").show();
                 errores = 1;
             }

             if (validarVacio(lat)) {
                 $("#<%=lblMapaPon.ClientID%>").hide();
             } else {
                 $("#<%=lblMapaPon.ClientID%>").show();
                 errores = 1;
             }

             if (validarVacio(long)) {
                 $("#<%=lblMapaPon.ClientID%>").hide();
             } else {
                 $("#<%=lblMapaPon.ClientID%>").show();
                 errores = 1;
             }


             $.each($('.txtTel'), function (index, elem) {

                 if ($(elem).val() != '' && $.isNumeric($(elem).val()) && $(elem).val().indexOf('.') == -1) {

                     $('#txttel' + $(elem).attr('id').split('_')[1]).html('');

                 }
                 else {

                     $('#txttel' + $(elem).attr('id').split('_')[1]).html('<span class="errorPeque">Ingresa un número de teléfono válido</span>');
                     errores = 1;
                 }


             });

             //validate facebook

             if($('[name="red_1"]').val()!='')
             {
                 var reg = /(?:(?:http|https):\/\/)?(?:www.)?facebook.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[?\w\-]*\/)?(?:profile.php\?id=(?=\d.*))?([\w\-]*)?/;
                 if (!reg.test($('[name="red_1"]').val())) {
                     errores = 1;
                     $('#error_1').html('<span class="errorPeque">Ingresa una dirección de facebook válida.</span>');
                     mensajeServidor(0, 'Ingresa una dirección de facebook válida.');

                 }
             }


             if($('[name="red_2"]').val()!='')
             {
                 var reg2 = /^@?(\w){1,15}$/;
                 if (!reg2.test($('[name="red_2"]').val())) {
                     errores = 1;
                     $('#error_2').html('<span class="errorPeque">Ingresa una dirección de twiter válida.</span>');
                     mensajeServidor(0, 'Ingresa una dirección de twiter válida.');

                 }
             }


   


             if (errores == 0) {
                 
                 //sacar telefonos
//                 var tels = $('.txtTel');
//                 var checks = $('.checkbox');
//                 var max = tels.length;
//                 var i = 0;
//                 var telefonos = '';
//                 var wats = '';
//                 for (i = 0; i < max; i++) {
//                     if (i == 0) {
//                         wats = wats + check.is(":checked") + '|';
//                         telefonos = telefonos + tels[i].value + '|';
//                     }
//                     else {
//                         wats = wats + checks[i].checked + '|';
//                         telefonos = telefonos + tels[i].value + '|';
//                     }
//                 }
                 //$("#form1").submit();

                 $("#<%=Button1.ClientID%>").trigger('click');
                 //PageMethods.btnIniciarControl_onclick(suc, dir, long, lat, telefonos, wats, callBackControl);
             }
         }

         function callBackControl(result) {
             if (result == '1') {
                 label = '<%=GetGlobalResourceObject("Globalresource", "guardar_exito" ) %> ';
                 alertify.success(label);
                 Limpiar();
             }
             else if (result == '-1') {
                 label = '<%=GetGlobalResourceObject("Globalresource", "guardar_error_noEmpresa" ) %> ';
                 alertify.error(label);
                 Limpiar();
             }
             else {
                 label = '<%=GetGlobalResourceObject("Globalresource", "guardar_falla" ) %> ';
                 alertify.error(label);
             }
         }

         function addTel() {

             $.get("../utils/others/phonesDel.htm", function (respons) {




                 respons = respons.replace("@lbl_telSucExpli", '<%=GetGlobalResourceObject("Globalresource", "lbl_telSucExpli" ) %>');
                 respons = respons.replace("@lbl_telSucExpliMas", '<%=GetGlobalResourceObject("Globalresource", "lbl_telSucExpliMas" ) %>');
                 respons = respons.replace("@lbl_UsarWhatsApp", '<%=GetGlobalResourceObject("Globalresource", "lbl_UsarWhatsApp" ) %>');
                 respons = respons.replace(new RegExp("@", "g"), $('#idCountphones').val() + "");
                 $('#idCountphones').val(parseInt($('#idCountphones').val()) + 1);
                 $("#divTelefonos").append(respons);
                 $("#divTelefonos").find('.masterTooltip').last().hover(function () {
                     // Hover over code
                     var title = $(this).attr('title');
                     
                     $(this).data('tipText', title).removeAttr('title');

                     $('<p class="tooltip"></p>')
                .text(title)
                .appendTo('body')
                .fadeIn('slow');
                 }, function () {
                     // Hover out code
                     $(this).attr('title', $(this).data('tipText'));
                     $('.tooltip').remove();
                 }).mousemove(function (e) {
                     var mousex = e.pageX + 20; //Get X coordinates
                     var mousey = e.pageY + 10; //Get Y coordinates
                     $('.tooltip')
                .css({ top: mousey, left: mousex })
                 });

                 $($("#divTelefonos").find('.masterTooltip')[$("#divTelefonos").find('.masterTooltip').size()-3]).hover(function () {
                     // Hover over code
                     var title = $(this).attr('title');

                     $(this).data('tipText', title).removeAttr('title');

                     $('<p class="tooltip"></p>')
                .text(title)
                .appendTo('body')
                .fadeIn('slow');
                 }, function () {
                     // Hover out code
                     $(this).attr('title', $(this).data('tipText'));
                     $('.tooltip').remove();
                 }).mousemove(function (e) {
                     var mousex = e.pageX + 20; //Get X coordinates
                     var mousey = e.pageY + 10; //Get Y coordinates
                     $('.tooltip')
                .css({ top: mousey, left: mousex })
                 });


             });

         }


         function delTel(elem) {

             $(elem).parent().parent().parent().remove();

         }



         //boton remover plaga
         $('body').on('click', '.btnRemoverPlaga', function () {
             $(this).parent().parent().remove();
         });

         function Limpiar() {

             $("#<%=txtNomSuc.ClientID%>").val("");
             $("#<%=txtDom.ClientID%>").val("");
             $("#<%= tbl_tel.ClientID %>").html('');
             $("#preview").html("");
             limpiaMensajes();
             PageMethods.cargaRedesSocialesWM($("#<%=idSuc.ClientID%>").val(),callBackCargaRedes);
         }

       
         function mensajeServidor(tipo, label) {
             if (tipo == 0) {
                 //error
                 alertify.error(label);
             }
             else if (tipo == 1) {
                 //exito
                 alertify.success(label);
             }
         }

         function eliminarImagen(id) {
             PageMethods.deleteImage(id,$("#<%=idSuc.ClientID%>").val(), deleteImage_callback);


         }


         function deleteImage_callback(sResult) {
             loadImages();
             if (sResult == '0') {
                 mensajeServidor(0, "ERROR!! No se pudo eliminar la imagen.");
                 

             } else if(sResult=='1')
             {
                 mensajeServidor(1, "Imagen eliminada con éxito");
             }
             
         }


         function eliminarSucursalWeb()
         {
         PageMethods.Delete_Sucursal($("#<%=idSuc.ClientID%>").val());
         }

         

    </script>

    <script type="text/javascript">
        function firefileUpload() {

            $('#ContentPlaceHolder1_nestedContent_photoimg').click();

        }
    </script>

   
    <script type="text/javascript">

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="nestedContent" runat="Server">
   
    <h2>
        <input id="idCountphones" type="hidden"  />
        <input id="image" name="image" type="hidden" />
         <input id="typeofload" name="image" type="hidden" runat="server" />
        <input id="idSuc" type="hidden" runat="server" />
        <asp:Literal ID="ltTiTulo" runat="server" Text='<%$ Resources:Globalresource, lbl_NuevaSuc %>'></asp:Literal></h2>
        <table width="100%">
        <tr>
        <td style="width:70%">
          <table width="100%">
        <tr>
            <td style="width: 68px;">
                <asp:Label ID="Label1" runat="server" Text='<%$ Resources:Globalresource, lbl_NomSuc %>'></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtNomSuc" runat="server" MaxLength="100" CssClass="cajaLarga masterTooltip"
                    title='<%$ Resources:Globalresource, lbl_NomSucExpli %>'></asp:TextBox>
                <asp:Label ID="lblSucPon" runat="server" CssClass="errorPeque" Text='<%$ Resources:Globalresource, lbl_CampoObligatorio %>'></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <%--<asp:Literal ID="Literal5" runat="server" Text='<%$ Resources:Globalresource, lbl_DomLocaliz %>'></asp:Literal>--%>
                <img id="imgHome" runat="server" src="../img/home.gif" width="30" height="30" />
            </td>
            <td>
                <asp:TextBox ID="txtDom" runat="server" MaxLength="100" CssClass="cajaLarga masterTooltip"
                    TextMode="MultiLine" onkeypress=" return limita(this, event,100)" onkeyup="cuenta(this, event,100)"
                    title='<%$ Resources:Globalresource, lbl_DomExpli %>'></asp:TextBox>
                <asp:Label ID="lblDirPon" runat="server" CssClass="errorPeque" Text='<%$ Resources:Globalresource, lbl_CampoObligatorio %>'></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
            <div id="divTelefonos">


            </div>
            
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <table id="tbl_tel" runat="server">
                    <tr>
                        <td colspan="2">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="div_redesS" runat="server">
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <table id="tbl_coordenadas" runat="server" width="100%">
                    <tr>
                        <td colspan="4">
                            <asp:Literal ID="Literal1" runat="server" Text='<%$ Resources:Globalresource, lbl_DanosUbicacion %>'></asp:Literal>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <div id="posicion">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Literal ID="Literal3" runat="server" Text='<%$ Resources:Globalresource, lbl_latitud %>'></asp:Literal>
                        </td>
                        <td>
                            <asp:Label ID="lblLatitud"  runat="server" Text="10"></asp:Label>
                            <input id="inputLatitud" name="inputLatitud" type="hidden" />
                        </td>
                        <td>
                            <asp:Literal ID="Literal4" runat="server" Text='<%$ Resources:Globalresource, lbl_longitud %>'></asp:Literal>
                        </td>
                        <td>
                            <asp:Label ID="lblLongitud"  runat="server" Text="10"></asp:Label>
                               <input id="inputLongitud" name="inputLongitud" type="hidden" />
                    </tr>
                    <tr>
                        <td colspan="4">
                            <asp:Label ID="lblMapaPon" runat="server" CssClass="errorPeque" Text='<%$ Resources:Globalresource, lblMapaPon %>'></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td id="tbl_mapa" colspan="2">
                <%-- <img src="../img/mapaLogin.jpg" />--%>
                <table>
                <tr>
                <td>
                ¿ Ya estás en Google maps ?
                <input id="searchTextField" name="searchTextField" type="text" size="50"/>
                </td>
                </tr>
                </table>  
              
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <table id="tbl_foto">
                    <tr>
                        <td class="cargaLogo">
                            
                        </td>
                        <td class="cargaLogo">
                            <div class="cargaLogo">
                                
                                
                                <div id='imageloadbutton' style="display:none;">
                                    <input type="file" name="photos[3]" id="photoimg" multiple="true" runat="server" />
                                </div>
                                <div>
                                </div>
                                <div id="respuesta" runat="server">
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
        <td colspan="2">
        <div id="map_canvas" style="width: 100%; height: 300px;">
                </div>
        </td>
        </tr>
         <tr>
            <td colspan="2" align="right">
                <input id="btnIniciar" class="botonStandar" runat="server" type="button" value='<%$ Resources:Globalresource, btn_Guardar %>'
                    onclick="javascript:validarControl();" />
                <asp:Button ID="eliminar" runat="server" Text="Eliminar Sucursal"  UseSubmitBehavior="False"
                    class="botonStandar" onclick="eliminar_Click" />
                
               
                
            </td>
        </tr>
    </table>
        </td>
        <td style="width:30%" valign="top">
        <div id="divImages" style="width:100%" valign="top">
               <table width="100%">
        <tr>
        <td>
        <h2>
        <asp:Literal ID="Literal2" runat="server" Text='<%$ Resources:Globalresource, lbl_DanosFotoSucursal %>'></asp:Literal>
        </h2>
        </td>
        </tr>
        <tr>
        <td>
        <div id='imageloadstatus' style='display: none'>
                                    <img src="../images/loader.gif" alt="Uploading...." /></div>
        </td>
        </tr>
        <tr>
        <td valign="top" align="center">
        <div id="images" style="width: 100%; min-height: 200px; background-color:rgb(249, 240, 206);" >
        
        <img src="../img/x-128.png" width="50px" height="50px" onclick="javascript:firefileUpload();" alt="new" style="cursor: pointer;"  class="masterTooltip" title="Agregar Imagen"  />

        <div id='preview' class="content" style="height:500px;overflow:auto; width: 100%; max-height:500px;"  >
        </div>


        </div>
        </td>
        </tr>
        </table>
        </div>
 
        
        </td>
        </tr>
        <tr>
        <td colspan="2">
            <input id="placeNameHidden" type="hidden" name="placeNameHidden" runat="server" />
        </td>
        </tr>
        </table>
    <asp:Button ID="Button1" runat="server" Text="Button" onclick="Button1_Click" style="display:none" UseSubmitBehavior="False"/>
    <%-- </div>--%>
   
</asp:Content>
