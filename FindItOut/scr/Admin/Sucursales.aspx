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

        function validarControl() {
            var suc = $("#<%=txtNomSuc.ClientID%>").val();
            var dir = $("#<%=txtDom.ClientID%>").val();
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
            var longi = 'xxx';
            var lati = 'yyy';
            PageMethods.btnIniciarControl_onclick(suc, dir, longi, lati, telefonos, wats, callBackControl);
        }

        function callBackControl(result) {
            if (result == '1') {
                label = '<%=GetGlobalResourceObject("Globalresource", "guardar_exito" ) %> ';
                alertify.success(label);
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
        $('body').on('click','.btnRemoverPlaga' , function () {
            $(this).parent().parent().remove();
        });

        function Limpiar() {

            $("#<%=txtNomSuc.ClientID%>").val("");
            $("#<%=txtDom.ClientID%>").val("");
            $("#<%= txtTel.ClientID %>").val("");
            $("#<%= CheckBox1.ClientID %>").prop("checked", "");
            $("#<%= tbl_tel.ClientID %>").html('');
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
                $("#error").html('Latitude:' + event.latLng.lat() + ', Longitude:' + event.latLng.lng());
            });

            google.maps.event.addListener(markerLocal, 'dragend', function (event) {
                $("#error").html('Latitude:' + event.latLng.lat() + ', Longitude:' + event.latLng.lng());
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
            $("#error").html('Latitude:' + position.coords.latitude + ', Longitude:' + position.coords.longitude);
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
    <%--<div id="scrolltable" style="overflow: auto; padding-right: 15px; padding-top: 15px;
        padding-left: 15px; padding-bottom: 15px; height: 250px; left: 100; top: 20;
        width: 98%">--%>
    <h2>
        <asp:Literal ID="ltTiTulo" runat="server" Text='<%$ Resources:Globalresource, lbl_NuevaSuc %>'></asp:Literal></h2>
    <div id="error">
    </div>
    <table>
        <tr>
            <td style="width: 68px;">
                <asp:Label ID="Label1" runat="server" Text='<%$ Resources:Globalresource, lbl_NomSuc %>'></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtNomSuc" runat="server" MaxLength="100" CssClass="cajaLarga" title='<%$ Resources:Globalresource, lbl_NomSucExpli %>'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <%--<asp:Literal ID="Literal5" runat="server" Text='<%$ Resources:Globalresource, lbl_DomLocaliz %>'></asp:Literal>--%>
                <img id="imgHome" runat="server" src="../img/home.gif" width="30" height="30" />
            </td>
            <td>
                <asp:TextBox ID="txtDom" runat="server" MaxLength="100" CssClass="cajaLarga" TextMode="MultiLine"
                    onkeypress=" return limita(this, event,100)" onkeyup="cuenta(this, event,100)"
                    title='<%$ Resources:Globalresource, lbl_DomExpli %>'></asp:TextBox>
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
                            <asp:TextBox ID="txtTel" runat="server" MaxLength="20" CssClass="cajaMed txtTel"
                                title='<%$ Resources:Globalresource, lbl_telSucExpli %>'></asp:TextBox>
                        </td>
                        <td>
                            <img width="20" id="imgAdd" src="../img/add.png" title='<%$ Resources:Globalresource, lbl_telSucExpliMas %>'
                                runat="server" onclick="addTel();" />
                        </td>
                        <td>
                            <span>
                                <asp:CheckBox ID="CheckBox1" runat="server" CssClass="checkbox" title='<%$ Resources:Globalresource, lbl_UsarWhatsApp %>' />
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
                        <td>
                            <asp:Literal ID="Literal3" runat="server" Text='<%$ Resources:Globalresource, lbl_latitud %>'></asp:Literal>
                        </td>
                        <td>
                            <asp:Label ID="lblLatitud" runat="server" Text="xxxxxxx"></asp:Label>
                        </td>
                        <td>
                            <asp:Literal ID="Literal4" runat="server" Text='<%$ Resources:Globalresource, lbl_longitud %>'></asp:Literal>
                        </td>
                        <td>
                            <asp:Label ID="lnlLongitud" runat="server" Text="xxxxxxx"></asp:Label>
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
    <%-- <table class="login">
        <tr>
            <td style="text-align: center;">
                <h2>
                    <asp:Literal ID="Literal1" runat="server" Text='<%$ Resources:Globalresource, lbl_MisSucursales %>'></asp:Literal></h2>
            </td>
        </tr>
        <tr>
            <td align="right" style="text-align: right;">
                <asp:Literal ID="Literal8" runat="server" Text='<%$ Resources:Globalresource, lbl_MisSucursalesNuevo %>'></asp:Literal>
                <asp:ImageButton ID="btnNueva" runat="server" ImageUrl="../img/pinMas.png" Width="25px"
                    ToolTip='<%$ Resources:Globalresource, lbl_MisSucursalesNuevo %>' OnClick="btnNueva_Click" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="grdSucursales" runat="server" DataKeyNames="idSuc" CssClass="gridViewChico"
                    AutoGenerateColumns="False" OnRowDataBound="grdSucursales_RowDataBound">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Image ID="img" runat="server" CausesValidation="False" Width="15px"></asp:Image>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="suc" />
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>--%>
</asp:Content>
