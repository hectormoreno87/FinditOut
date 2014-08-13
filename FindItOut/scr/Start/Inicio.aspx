<%@ Page Title="" Language="C#" MasterPageFile="MasterPageLogin.master" AutoEventWireup="true"
    CodeFile="Inicio.aspx.cs" Inherits="Inicio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Scripts/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="../Scripts/Validaciones.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            limpiaMensajes();
        });

        function limpiaMensajes() {
            $("#<%=lblCorreoPon.ClientID%>").hide();
            $("#<%=lblPassPon.ClientID%>").hide();
            $("#<%=lblCorreoMal.ClientID%>").hide();
        }

        function validar() {
            limpiaMensajes();

            var errores = 0;
            var mail = $("#<%=txtMail.ClientID%>");
            var pass = $("#<%=txtPass.ClientID%>");
            //mail
            if (validarVacio(mail)) {
                $("#<%=lblCorreoPon.ClientID%>").hide();
                if (validarEmail(mail.val())) {
                    $("#<%=lblCorreoMal.ClientID%>").hide();
                }
                else {
                    $("#<%=lblCorreoMal.ClientID%>").show();
                    errores = 1;
                }
            }
            else {
                $("#<%=lblCorreoPon.ClientID%>").show();
                errores = 1;
            }

            //pass
            if (validarVacio(pass)) {
                $("#<%=lblPassPon.ClientID%>").hide();
            }
            else {
                $("#<%=lblPassPon.ClientID%>").show();
                errores = 1;
            }

            if (errores == 0) {
                conectarServidor(mail.val(), pass.val());
            }
        }

        function conectarServidor(mail, pass) {
            //alert(mail + '  ' + pass);
            PageMethods.btnIniciar_onclick(mail, pass, redirigir);
        }

        function redirigir() {
            window.location = "Parentesis.aspx";
        }
              

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table>
        <tr>
            <td colspan="3" style="text-align: center;" class="titulo_tabla">
                <asp:Literal runat="server" Text='<%$ Resources:GlobalResource, Bienvenida_IniciaSesion%>'></asp:Literal>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Literal ID="Literal1" runat="server" Text='<%$ Resources:Globalresource, lbl_Correo %>'></asp:Literal>
            </td>
            <td>
                <asp:TextBox ID="txtMail" runat="server" MaxLength="100" CssClass="cajaLarga"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Label ID="lblCorreoPon" runat="server" CssClass="errorPeque" Text='<%$ Resources:Globalresource, lbl_CampoObligatorio %>'></asp:Label>
                <asp:Label ID="lblCorreoMal" runat="server" CssClass="errorPeque" Text='<%$ Resources:Globalresource, lbl_CorreoMal %>'></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 30px;">
                <asp:Literal ID="Literal2" runat="server" Text='<%$ Resources:Globalresource, lbl_Pass %>'></asp:Literal>
            </td>
            <td>
                <asp:TextBox ID="txtPass" runat="server" MaxLength="15" TextMode="Password" CssClass="cajaLarga"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Label ID="lblPassPon" runat="server" CssClass="errorPeque" Text='<%$ Resources:Globalresource, lbl_CampoObligatorio %>'></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="3" align="right" style="text-align: right;">
                <input id="btnIniciar" class="botonStandar" runat="server" type="button" value='<%$ Resources:Globalresource, btn_Entrar %>'
                    onclick="javascript:validar();" />
            </td>
        </tr>
        <tr>
            <td colspan="3" align="right" style="text-align: right;">
                <asp:LinkButton CssClass="link" ID="LinkButton1" runat="server" Text='<%$ Resources:Globalresource, link_OlvidePass %>'
                    PostBackUrl="~/Start/SendPass.aspx"></asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td colspan="3" align="right" style="text-align: right;">
                <asp:LinkButton CssClass="link" ID="LinkButton2" runat="server" PostBackUrl="~/Start/Registro1.aspx"
                    Text='<%$ Resources:Globalresource, link_Aqui %>'></asp:LinkButton>
            </td>
        </tr>
    </table>
</asp:Content>
