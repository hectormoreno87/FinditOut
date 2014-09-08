<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageLogin.master" AutoEventWireup="true"
    CodeFile="SendPass.aspx.cs" Inherits="SendPass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Scripts/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="../Scripts/Validaciones.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.min.js" type="text/javascript"></script>
    <script src="../Scripts/1.9.2.jquery-ui.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.blockUI.js" type="text/javascript"></script>
    
    
    <script type="text/javascript">
        $j = jQuery.noConflict();
        //function to block the whole page  
        function blockPage() {
            $j.blockUI({ message: '<img src="/img/loading32.gif" /><h1> Loading...</h1>',
                css: {
                    border: 'none',
                    padding: '15px',
                    '-webkit-border-radius': '10px',
                    '-moz-border-radius': '10px',
                    opacity: .9
                }
            });
            return false;
        }
        //function to unblock the page  
        function unblockPage() {
            $j.unblockUI();
        }  
   </script>  


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
            var mail = $("#<%=txtMail.ClientID%>").val();
            //mail
            if (validarVacio(mail)) {
                $("#<%=lblCorreoPon.ClientID%>").hide();
                if (validarEmail(mail)) {
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
                conectarServidor(mail);
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
     <input id="pageDemo1" type="submit" value="Default Message" />
     <table>
        <tr>
            <td>
                <table class="login">
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
                        <td align="right" style="text-align: right;">
                            <input id="btnIniciar" class="botonStandar" runat="server" type="button" value='<%$ Resources:Globalresource, btn_EnviarPass %>'
                                onclick="javascript:validar();" />
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                <table>
                    <tr>
                        <td style="width: 60%">
                            <h1>
                                <asp:Literal ID="Literal3" runat="server" Text='<%$ Resources:GlobalResource, Bienvenida_FindItOut%>'></asp:Literal></h1>
                            <p>
                                <asp:Literal ID="Literal4" runat="server" Text='<%$ Resources:GlobalResource,lbl_bienvenida1%>'></asp:Literal>
                            </p>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
     <div id="loginForm" style="display:none">
            <p><label>Username:</label><input type="text" name="demo1" /></p>
            <p><label>Password:</label><input type="text" name="demo1" /></p>
        </div>

</asp:Content>
