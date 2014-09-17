<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageLogin.master" AutoEventWireup="true"
    CodeFile="Inicio.aspx.cs" Inherits="Inicio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Scripts/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="../Scripts/Validaciones.js" type="text/javascript"></script>
    <script src="../Scripts/1.8.2.min.js" type="text/javascript"></script>
    <style type="text/css">
        
    </style>
    <script type="text/javascript">

        $(document).ready(function () {
            limpiaMensajes();
            toolTip();
        });

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



        $(function () {

            //            var pass = $("#<%=txtPass.ClientID%>");
            //            pass.tooltip({ placement: 'right' });
            $("#<%=txtPass.ClientID%>").tooltip({ placement: 'right' });

        });

        function limpiaMensajes() {
            $("#<%=lblCorreoPon.ClientID%>").hide();
            $("#<%=lblPassPon.ClientID%>").hide();
            $("#<%=lblCorreoMal.ClientID%>").hide();
        }

        function validar() {
            limpiaMensajes();

            var errores = 0;
            var mail = $("#<%=txtMail.ClientID%>").val();
            var pass = $("#<%=txtPass.ClientID%>").val();
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

            //pass
            if (validarVacio(pass)) {
                $("#<%=lblPassPon.ClientID%>").hide();
            }
            else {
                $("#<%=lblPassPon.ClientID%>").show();
                errores = 1;
            }

            if (errores == 0) {
                conectarServidor(mail, pass);
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
            <td>
                <table class="login">
                    <tr>
                        <td colspan="3" style="text-align: center;" class="titulo_tabla">
                            <asp:Literal ID="Literal1" runat="server" Text='<%$ Resources:GlobalResource, Bienvenida_IniciaSesion%>'></asp:Literal>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Literal ID="Literal2" runat="server" Text='<%$ Resources:Globalresource, lbl_Correo %>'></asp:Literal>
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
                            <asp:Literal ID="Literal5" runat="server" Text='<%$ Resources:Globalresource, lbl_Pass %>'></asp:Literal>
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
</asp:Content>
