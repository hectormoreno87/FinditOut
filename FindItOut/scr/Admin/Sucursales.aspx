<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterAdmin.master" AutoEventWireup="true"
    CodeFile="Sucursales.aspx.cs" Inherits="Admin_Sucursales" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Myhead" runat="Server">
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDgswrmT3KpX1iyQjOjDq_G2LAP5cpz5KY&sensor=TRUE">
    </script>
    <script src="../Scripts/richmarker.js" type="text/javascript"></script>
    <script src="../Scripts/Validaciones.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="../Scripts/alertify.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="nestedContent" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            limpiaMensajes();
            toolTip();

            $("#<%=photoimg.ClientID%>").on('change', function () {
                $("#form1").ajaxForm({ target: '#preview',
                    beforeSubmit: function () {

                        //console.log('ttest');
                        $("#imageloadstatus").show();
                        $("#imageloadbutton").hide();
                        return;
                    },
                    success: function (s) {
                        $("#preview").html("");
                        $("#imageloadstatus").hide();
                        $("#imageloadbutton").show();
                        cargaImagen();
                    },
                    error: function () {
                        // console.log('xtest');                        
                        $("#imageloadstatus").hide();
                        $("#imageloadbutton").show();
                        var label = '<%=GetGlobalResourceObject("Globalresource", "guardarLogo_error" ) %> ';
                        alertify.error(label);
                    }
                }).submit();
            });
        });

        function cargaImagen() {
            $("#preview").html("");
            PageMethods.sacaImagen(callBackSacaImagen);
        }
        function callBackSacaImagen(carpeta) {
            var logo = "" + carpeta + "";
            $("#imageloadstatus").hide();
            $("#imageloadbutton").show();
            var d = new Date();
            $("#preview").html("<img src='..\\EmpresasFiles\\" + logo + "?" + d.getTime() + "' />");
        }

        function limpiaMensajes() {
            $(".errorPeque").hide();
        }

        function toolTip() {
            $('.masterTooltip').hover(function () {
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

            if (errores == 0) {
                var check = $("#<%=CheckBox1.ClientID%>");
                //sacar telefonos
                var tels = $('.txtTel');
                var checks = $('.checkbox');
                var max = tels.length;
                var i = 0;
                var telefonos = '';
                var wats = '';
                for (i = 0; i < max; i++) {
                    if (i == 0) {
                        wats = wats + check.is(":checked") + '|';
                        telefonos = telefonos + tels[i].value + '|';
                    }
                    else {
                        wats = wats + checks[i].checked + '|';
                        telefonos = telefonos + tels[i].value + '|';
                    }
                }
                PageMethods.btnIniciarControl_onclick(suc, dir, long, lat, telefonos, wats, callBackControl);
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
            var txt = $("#<%= txtTel.ClientID %>").clone().html();
            var chk = $("#<%= CheckBox1.ClientID %>").clone().html();
            var html = '<tr>'
                            + '<td style="width: 65px;"> </td>'
                            + '<td>'
                            + '<input name="<%= txtTel.UniqueID %>" class="cajaMed txtTel">'
                                    + txt
                            + '</input>'
                            + '</td>'
                            + '<td>'
                            + '<img src="../img/del.png" class="btnRemoverPlaga" width=20px"/>'
                            + '</td>'
                            + '<td></td>'
                            + '<td>'
                            + '<input type="checkbox" name="<%= CheckBox1.UniqueID %>" class="checkbox" />'
                            + '</td>'
                            + '<td style="text-align: right;">'
                            + '<img src="../img/whatsappLogo.png" width="25px" height="25px" />'
                            + '</td>'
                        + '</tr>';
            //$('#tbl_tel').append(html);
            $("#<%= tbl_tel.ClientID %>").append(html);
        }

        //boton remover plaga
        $('body').on('click', '.btnRemoverPlaga', function () {
            $(this).parent().parent().remove();
        });

        function Limpiar() {

            $("#<%=txtNomSuc.ClientID%>").val("");
            $("#<%=txtDom.ClientID%>").val("");
            $("#<%= txtTel.ClientID %>").val("");
            $("#<%= CheckBox1.ClientID %>").prop("checked", "");
            $("#<%= tbl_tel.ClientID %>").html('');
            limpiaMensajes();
            PageMethods.cargaRedesSocialesWM(callBackCargaRedes);
        }

        function callBackCargaRedes(cadena) {
            $("#<%= div_redesS.ClientID %>").html('');
            $("#<%= div_redesS.ClientID %>").html(cadena);
        }

    </script>
    <script type="text/javascript">

        var mapGlobal;
        var markerLocal;
        var mapOptionsGlobal;
        var populationOptions;

        $(function () {
            initialize();
            $.ajaxSetup({ cache: false });
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
                $("#<%=lblLongitud.ClientID%>").text(event.latLng.lng());
            });

            google.maps.event.addListener(markerLocal, 'dragend', function (event) {
                //$("#posicion").html('Latitude:' + event.latLng.lat() + ', Longitude:' + event.latLng.lng());
                $("#<%=lblLatitud.ClientID%>").text(event.latLng.lat());
                $("#<%=lblLongitud.ClientID%>").text(event.latLng.lng());
            });
        }

        var x = document.getElementById("posicion");
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
            //$("#posicion").html('Latitude:' + position.coords.latitude + ', Longitude:' + position.coords.longitude);
            $("#<%=lblLatitud.ClientID%>").text(event.latLng.lat());
            $("#<%=lblLongitud.ClientID%>").text(event.latLng.lng());

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
    </script>
    <h2>
        <asp:Literal ID="ltTiTulo" runat="server" Text='<%$ Resources:Globalresource, lbl_NuevaSuc %>'></asp:Literal></h2>
    <table>
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
                <table runat="server">
                    <tr>
                        <td style="width: 65px;">
                            <img src="../img/tel.png" width="25px" height="30px" />
                        </td>
                        <%--<td><asp:Literal ID="Literal2" runat="server" Text='<%$ Resources:Globalresource, lbl_telSuc %>'></asp:Literal></td>--%>
                        <td>
                            <asp:TextBox ID="txtTel" runat="server" MaxLength="20" CssClass="cajaMed txtTel masterTooltip"
                                title='<%$ Resources:Globalresource, lbl_telSucExpli %>'></asp:TextBox>
                        </td>
                        <td>
                            <img width="20" id="imgAdd" src="../img/add.png" class="masterTooltip" title='<%$ Resources:Globalresource, lbl_telSucExpliMas %>'
                                runat="server" onclick="addTel();" />
                        </td>
                        <td>
                            <span>
                                <asp:CheckBox ID="CheckBox1" runat="server" CssClass="checkbox masterTooltip" title='<%$ Resources:Globalresource, lbl_UsarWhatsApp %>' />
                            </span>
                        </td>
                        <td style="text-align: right;">
                            <img src="../img/whatsappLogo.png" width="25px" height="25px" />
                        </td>
                    </tr>
                </table>
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
                            <asp:Label ID="lblLatitud" runat="server" Text=""></asp:Label>
                        </td>
                        <td>
                            <asp:Literal ID="Literal4" runat="server" Text='<%$ Resources:Globalresource, lbl_longitud %>'></asp:Literal>
                        </td>
                        <td>
                            <asp:Label ID="lblLongitud" runat="server" Text=""></asp:Label>
                        </td>
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
                <div id="map_canvas" style="width: 500px; height: 300px;">
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <table id="tbl_foto">
                    <tr>
                        <td>
                            <asp:Literal ID="Literal2" runat="server" Text='<%$ Resources:Globalresource, lbl_DanosFotoSucursal %>'></asp:Literal>
                        </td>
                        <td>
                            <div class="cargaLogo">
                                <div id='preview'>
                                </div>
                                <div id='imageloadstatus' style='display: none'>
                                    <img src="../images/loader.gif" alt="Uploading...." /></div>
                                <div id='imageloadbutton' onclick="javascript:addalgo();">
                                    <input type="file" name="photos[]" id="photoimg" multiple="true" runat="server" />
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
    </table>
    <%-- </div>--%>
    <table width="100%">
        <tr>
            <td colspan="2" align="right">
                <input id="btnIniciar" class="botonStandar" runat="server" type="button" value='<%$ Resources:Globalresource, btn_Guardar %>'
                    onclick="javascript:validarControl();" />
                <input id="btnCancelar" class="botonStandar" runat="server" type="button" value='<%$ Resources:Globalresource, btn_Cancelar %>'
                    onclick="javascript:Limpiar();" />
            </td>
        </tr>
    </table>
</asp:Content>
