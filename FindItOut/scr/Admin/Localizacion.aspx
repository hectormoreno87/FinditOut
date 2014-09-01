<%@ Page Title="" Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true"
    CodeFile="Localizacion.aspx.cs" Inherits="Admin_Localizacion" %>

<%@ Register Src="~/Controls/Sucursal.ascx" TagName="Sucursal" TagPrefix="uc2" %>
<asp:Content ID="MyContent1" ContentPlaceHolderID="Myhead" runat="Server">
    <script src="../Scripts/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="../Scripts/Validaciones.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.min.js" type="text/javascript"></script>
    <script src="../Scripts/Validaciones.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="MyContent2" ContentPlaceHolderID="nestedContent" runat="Server">
    <script type="text/javascript">

        $(document).ready(function () {
            limpiaMensajes();
        });

        $(function () {
            $(document).tooltip();
        });

        function limpiaMensajes() {
            $("#<%=lblCorreoMal.ClientID%>").hide();
        }

        function validar() {
            limpiaMensajes();
            var errores = 0;

            var user = $("#<%=txtUser.ClientID%>").val();
            var empre = $("#<%=txtEmpre.ClientID%>").val();
            var desc = $("#<%=txtDesc.ClientID%>").val();
            var logo = $("#<%=txtLogo.ClientID%>").val();
            var web = $("#<%=txtWeb.ClientID%>").val();
            var mail = $("#<%=txtMail.ClientID%>");

            if (validarVacio(mail)) {
                if (validarEmail(mail.val())) {
                    $("#<%=lblCorreoMal.ClientID%>").hide();
                }
                else {
                    $("#<%=lblCorreoMal.ClientID%>").show();
                    errores = 1;
                }
            }
            if (errores == 0) {
                PageMethods.btnIniciar_onclick(user, desc, logo, web, mail.val(), empre, callBack);
            }
        }

        function callBack(resutl) {
            if (result = '1')
                alert('Guadado');
            else
                alert('No guardado :(');
        }
    </script>
    <table class="login">
        <tr>
            <td colspan="2" style="text-align:center;">
                <h2>
                    <asp:Literal ID="Literal9" runat="server" Text='<%$ Resources:Globalresource, lbl_MiEmpreLocaliz %>'></asp:Literal>
                </h2>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Literal ID="Literal2" runat="server" Text='<%$ Resources:Globalresource, lbl_UserLocaliz %>'></asp:Literal>
            </td>
            <td>
                <asp:TextBox ID="txtUser" runat="server" MaxLength="50" CssClass="cajaLarga" title='<%$ Resources:Globalresource, lbl_UserExpLocaliz %>'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Literal ID="Literal5" runat="server" Text='<%$ Resources:Globalresource, lbl_EmpreLocaliz %>'></asp:Literal>
            </td>
            <td>
                <asp:TextBox ID="txtEmpre" runat="server" MaxLength="100" CssClass="cajaLarga" title='<%$ Resources:Globalresource, lbl_EmpreExpLocaliz %>'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Literal ID="Literal4" runat="server" Text='<%$ Resources:Globalresource, lbl_DescrLocaliz %>'></asp:Literal>
            </td>
            <td>
                <asp:TextBox ID="txtDesc" runat="server" MaxLength="250" CssClass="cajaLarga" TextMode="MultiLine"
                    onkeypress=" return limita(this, event,250)" onkeyup="cuenta(this, event,250)"
                    onchange="limita(this, event,250)" title='<%$ Resources:Globalresource, lbl_DirExpLocaliz %>'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Literal ID="Literal7" runat="server" Text='<%$ Resources:Globalresource, lbl_WebLocaliz %>'></asp:Literal>
                <%-- <img id="imgWeb" runat="server" src="../img/web1.png" width="28" height="28" />--%>
            </td>
            <td>
                <asp:TextBox ID="txtWeb" runat="server" MaxLength="100" CssClass="cajaLarga" title='<%$ Resources:Globalresource, lbl_WebExpli %>'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Literal ID="Literal6" runat="server" Text='<%$ Resources:Globalresource, lbl_MailLocaliz %>'></asp:Literal>
                <%-- <img id="imgMail" runat="server" src="../img/mail.png" width="25" height="30" />--%>
            </td>
            <td>
                <asp:TextBox ID="txtMail" runat="server" MaxLength="100" CssClass="cajaLarga" title='<%$ Resources:Globalresource, lbl_MailExpli %>'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Label ID="lblCorreoMal" runat="server" CssClass="errorPeque" Text='<%$ Resources:Globalresource, lbl_CorreoMal %>'></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Literal ID="Literal3" runat="server" Text='<%$ Resources:Globalresource, lbl_LogoLocaliz %>'></asp:Literal>
            </td>
            <td>
                <asp:TextBox ID="txtLogo" runat="server" MaxLength="250" CssClass="cajaLarga" title='<%$ Resources:Globalresource, lbl_LogoExpLocaliz %>'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="right">
                <input id="btnIniciar" class="botonStandar" runat="server" type="button" value='<%$ Resources:Globalresource, btn_Guardar %>'
                    onclick="javascript:validar();" />
            </td>
        </tr>
    </table>
    <table class="login">
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
            <asp:GridView ID="grdSucursales" runat="server" DataKeyNames="idSuc" CssClass = "gridViewChico" 
                AutoGenerateColumns="False" OnRowDataBound="grdSucursales_RowDataBound">
                <Columns>
                    <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Image ID="img" runat="server" CausesValidation="False" Width="15px" ></asp:Image>
                                </ItemTemplate>
                            </asp:TemplateField>
                    <asp:BoundField DataField="suc"  />
                </Columns>
            </asp:GridView> 
        </td>
        </tr>
    </table>
    <uc2:Sucursal ID="sucursal1" runat="server" />
</asp:Content>
