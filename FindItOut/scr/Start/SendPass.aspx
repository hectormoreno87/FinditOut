<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageLogin.master" AutoEventWireup="true"
    CodeFile="SendPass.aspx.cs" Inherits="SendPass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Scripts/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="../Scripts/Validaciones.js" type="text/javascript"></script>
   
    <script type="text/javascript">

        $(document).ready(function () {
            limpiaMensajes();
        });

        function limpiaMensajes() {
            $("#<%=lblCorreoPon.ClientID%>").hide();
            $("#<%=lblCorreoMal.ClientID%>").hide();
        }

        function validar() {
            limpiaMensajes();

            var errores = 0;
            var mail = $("#<%=txtMail.ClientID%>");
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

            if (errores == 0) {
                conectarServidor(mail.val());
            }
        }

        function conectarServidor(mail) {
            //alert(mail + '  ' + pass);
            PageMethods.btnIniciar_onclick(mail, redirigir);
        }

        function redirigir() {
            window.location = "Parentesis.aspx";
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table>
        <tr>
            <td style="text-align: center;" class="titulo_tabla">
               
                    <asp:Literal ID="Literal1" runat="server" Text='<%$ Resources:GlobalResource, Bienvenida_EnvioPass%>'></asp:Literal>
               
            </td>
        </tr>
        <tr>
            <td style="text-align: left; word-wrap: break-word; width: 280px;">
                <h8>
                    <asp:Literal ID="Literal2" runat="server" Text='<%$ Resources:Globalresource, lbl_EnvioPass %>'></asp:Literal>
                </h8>
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
            <td align="right"  style="text-align:right;">
                <input id="btnIniciar" class="botonStandar" runat="server" type="button" value='<%$ Resources:Globalresource, btn_EnviarPass %>'
                    onclick="javascript:validar();" />
            </td>
        </tr>
    </table>
</asp:Content>
