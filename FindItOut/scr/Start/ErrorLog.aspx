<%@ Page Title="" Language="C#" MasterPageFile="MasterPageLogin.master" AutoEventWireup="true"
    CodeFile="ErrorLog.aspx.cs" Inherits="ErrorLog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   <script src="../Scripts/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="../Scripts/Validaciones.js" type="text/javascript"></script>
    <link href="../Styles/StyleSheet0.css" rel="stylesheet" type="text/css" />
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
        <%--<tr>
            <td style="text-align: left;">
                <h2>
                    <asp:Literal ID="lblErrorMail" runat="server" Text='<%$ Resources:GlobalResource, EntrarAlSistema%>'></asp:Literal>
                </h2>
            </td>
        </tr>--%>
        <tr>
            <td class="titulo_tabla" style="text-align: center;">
             
                    <asp:Literal ID="lblTipoError" runat="server"></asp:Literal>
               
            </td>
        </tr>
        <tr>
            <td style="text-align: left; word-wrap: break-word; width: 200px;">
                <h8>
                    <asp:Literal ID="lblDescError" runat="server" ></asp:Literal>
                </h8>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Literal ID="Literal3" runat="server" Text='<%$ Resources:Globalresource, lbl_Correo %>'></asp:Literal>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtMail" runat="server" MaxLength="100" CssClass="cajaLarga"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblCorreoPon" runat="server" CssClass="errorPeque" Text='<%$ Resources:Globalresource, lbl_CampoObligatorio %>'></asp:Label>
                <asp:Label ID="lblCorreoMal" runat="server" CssClass="errorPeque" Text='<%$ Resources:Globalresource, lbl_CorreoMal %>'></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Literal ID="Literal4" runat="server" Text='<%$ Resources:Globalresource, lbl_Pass %>'></asp:Literal>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtPass" runat="server" MaxLength="15" TextMode="Password" CssClass="cajaLarga"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblPassPon" runat="server" CssClass="errorPeque" Text='<%$ Resources:Globalresource, lbl_CampoObligatorio %>'></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 50px;text-align:right;" >
                <input id="btnIniciar" class="botonStandar" runat="server" type="button" value='<%$ Resources:Globalresource, btn_Entrar %>'
                    onclick="javascript:validar();" />
            </td>
        </tr>
        <tr>
            <td align="right" style="text-align:right;">
                <asp:LinkButton CssClass="link" ID="LinkButton1" runat="server" Text='<%$ Resources:Globalresource, link_OlvidePass %>'
                    PostBackUrl="SendPass.aspx"></asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td align="right" style="text-align:right;">
                <asp:LinkButton ID="LinkButton2" runat="server" CssClass="link" PostBackUrl="Registro1.aspx"
                    Text='<%$ Resources:Globalresource, link_RegistrateAqui %>'></asp:LinkButton>
            </td>
        </tr>
    </table>
</asp:Content>
