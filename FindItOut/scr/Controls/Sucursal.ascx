<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Sucursal.ascx.cs" Inherits="Controls_Sucursal" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Panel ID="pnlErrorMessageControl" runat="server" CssClass="modalPopup" Style="display: none;">
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
        function callBackControl(resutl) {
            if (result = '1') {
                alert('Guadado');
                location.href = "Localizacion.aspx";
            }
            else
                alert('No guardado :(');
        }    

        function addTel() {
            var txt = $("#<%= txtTel.ClientID %>").clone().html();
            var chk = $("#<%= CheckBox1.ClientID %>").clone().html();
            var html = '<tr>'
                            + '<td> </td>'
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
        $('.btnRemoverPlaga').live('click', function () {

            $(this).parent().parent().remove();
        });

    </script>
    <div id="scrolltable" style="overflow: auto; padding-right: 15px; padding-top: 15px;
        padding-left: 15px; padding-bottom: 15px; height: 250px; left: 100; top: 20;
        width: 98%">
        <h2>
            <asp:Literal ID="ltTiTulo" runat="server"></asp:Literal></h2>
        <%--<table>
            <tr>
                <td valign="top" style="width:40px;">
                    <asp:Image ID="btnBackMenu1" src="../img/atras.png" runat="server" Width="50px" Height="150px" onclick="menu1();" ToolTip="Jotp" />
                    <asp:Image ID="btnBackMenu2" src="../img/atras.png" runat="server" Width="50px" Height="150px" onclick="menu2();" />
                </td>
                <td>--%>
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="Literal1" runat="server" Text='<%$ Resources:Globalresource, lbl_NomSuc %>'></asp:Label>
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
                       <%-- <tr>
                            <td>
                                <%-- <asp:Literal ID="Literal2" runat="server" Text='<%$ Resources:Globalresource, lbl_WebLocaliz %>'></asp:Literal>
                                <img id="imgWeb" runat="server" src="../img/web1.png" width="28" height="28" />
                            </td>
                            <td>
                                <asp:TextBox ID="txtWeb" runat="server" MaxLength="100" CssClass="cajaLarga" title='<%$ Resources:Globalresource, lbl_WebExpli %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%--<asp:Literal ID="Literal6" runat="server" Text='<%$ Resources:Globalresource, lbl_MailLocaliz %>'></asp:Literal>
                                <img id="imgMail" runat="server" src="../img/mail.png" width="25" height="30" />
                            </td>
                            <td>
                                <asp:TextBox ID="txtMail" runat="server" MaxLength="100" CssClass="cajaLarga" title='<%$ Resources:Globalresource, lbl_MailExpli %>'></asp:TextBox>
                            </td>
                        </tr>--%>
                        <tr>
                            <td colspan="2">
                                <table id="tbl_tel" runat="server">
                                    <tr>
                                        <td colspan="2">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:65px;">
                                            <img src="../img/tel.png" width="25px" height="30px" />
                                        </td>
                                        <%--<td>
                                <asp:Literal ID="Literal2" runat="server" Text='<%$ Resources:Globalresource, lbl_telSuc %>'></asp:Literal>
                            </td>--%>
                                        <td>
                                            <asp:TextBox ID="txtTel" runat="server" MaxLength="20" CssClass="cajaMed txtTel" title='<%$ Resources:Globalresource, lbl_telSucExpli %>'></asp:TextBox>
                                        </td>
                                        <td>
                                            <img width="20" id="imgAdd" src="../img/add.png" title='<%$ Resources:Globalresource, lbl_telSucExpliMas %>'
                                                runat="server" onclick="addTel();" />
                                        </td>
                                        <td style="width: 20px;">
                                        </td>
                                        <td>
                                            <span>
                                                <asp:CheckBox ID="CheckBox1" runat="server"  CssClass="checkbox" title='<%$ Resources:Globalresource, lbl_UsarWhatsApp %>' />
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
                            <td id="tbl_mapa" runat="server" colspan="2">
                                <img src="../img/mapaLogin.jpg" />
                            </td>
                        </tr>
                    </table>
      <%--          </td>
                <td valign="top">
                    <asp:Image ID="btnToMenu2" src="../img/sigue.png" runat="server" Width="50px" Height="150px"  onclick="menu2();" />
                    <asp:Image ID="btnToMenu3" src="../img/sigue.png" runat="server" Width="50px" Height="150px"  onclick="menu3();" />
                </td>
            </tr>
        </table>--%>
    </div>
    <table width="100%">
        <tr>
            <td colspan="2" align="right">
            <input id="btnIniciar" class="botonStandar" runat="server" type="button" value='<%$ Resources:Globalresource, btn_Guardar %>'
                    onclick="javascript:validarControl();" />                
                <asp:Button runat="server" ID="btnOKMessageGralControl" Text='<%$ Resources:Globalresource, btn_Cancelar %>' />
            </td>
        </tr>
    </table>
</asp:Panel>
<asp:LinkButton runat="server" ID="lnkHiddenMdlPopupControl" Text="" Enabled="false" />
<asp:ModalPopupExtender ID="mdlPopupMessageGralControl" runat="server" BackgroundCssClass="modalBackground"
    PopupControlID="pnlErrorMessageControl" TargetControlID="lnkHiddenMdlPopupControl"
    CancelControlID="btnOKMessageGralControl">
</asp:ModalPopupExtender>
