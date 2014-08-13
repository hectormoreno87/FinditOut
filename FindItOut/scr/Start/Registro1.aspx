<%@ Page Title="" Language="C#" MasterPageFile="MasterPageLogin.master" AutoEventWireup="true"
    CodeFile="Registro1.aspx.cs" Inherits="Registro1" %>

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
            $("#<%=lblPassPon1.ClientID%>").hide();
            $("#<%=lblCorreoMal.ClientID%>").hide();
            $("#<%=lblErrorPass.ClientID %>").hide();
        }

        function validar() {
            limpiaMensajes();

            var errores = false;
            var mail = $("#<%=txtMail.ClientID%>");
            var pass = $("#<%=txtPass.ClientID%>");
            var confirm = $("#<%=txtConfirm.ClientID%>");
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
                errores = true;
            }

            //confirm
            if (validarVacio(confirm)) {
                $("#<%=lblPassPon1.ClientID%>").hide();
            }
            else {
                $("#<%=lblPassPon1.ClientID%>").show();
                errores = true;
            }
            if (!errores) {
                //comparar contraseñas
                if (pass.val() == confirm.val()) {
                }

                else {
                    $("#<%=lblErrorPass.ClientID %>").show();
                    $("#<%=txtPass.ClientID%>").value = "";
                    $("#<%=txtConfirm.ClientID%>").value = "";
                    errores = true;
                }
            }
            if (errores) {
                //no hacer nada
            }
            else {
                //guardar en base de datos
                PageMethods.btnCrearCuenta_onclick(mail.val(), pass.val(), confirm.val(), callBackCrearCuenta);
            }
        }

        function callBackCrearCuenta(valor) {
            if (valor == -1) {
                //error en pass
                $("#<%=lblErrorPass.ClientID %>").show();
                $("#<%=txtPass.ClientID%>").value = "";
                $("#<%=txtConfirm.ClientID%>").value = "";
            }  
            else
                window.location = "Parentesis.aspx";
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table >
        <tr>
            <td style="text-align: center;" class="titulo_tabla">
                
                    <asp:Literal ID="Literal1" runat="server" Text='<%$ Resources:GlobalResource, Bienvenida_Registro1%>'></asp:Literal>
               
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
            <td style="word-wrap: break-word; width: 70px;">
                <asp:Literal ID="literla8" runat="server" Text='<%$ Resources:Globalresource, lbl_ConfirmPass %>'></asp:Literal>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtConfirm" runat="server" MaxLength="15" TextMode="Password" CssClass="cajaLarga"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblPassPon1" runat="server" CssClass="errorPeque" Text='<%$ Resources:Globalresource, lbl_CampoObligatorio %>'></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="word-wrap: break-word;">
                <asp:Label ID="lblErrorPass" runat="server" CssClass="errorPeque" Text='<%$ Resources:Globalresource, lbl_PassConfirmError %>'></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="right" style="text-align:right;">
                <input id="btnIniciar" class="botonStandar" runat="server" type="button" value='<%$ Resources:Globalresource, btn_CrearCuenta %>'
                    onclick="javascript:validar();" />
            </td>
        </tr>
    </table>
</asp:Content>
