<%@ Page Title="" Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true" CodeFile="Localizacion.aspx.cs" Inherits="Admin_Localizacion" %>

<asp:Content ID="MyContent1" ContentPlaceHolderID="Myhead" runat="Server">
    <script src="../Scripts/Validaciones.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="../Scripts/alertify.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../Scripts/jquery.wallform.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
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
            $("#preview").html("<img src='..\\EmpresasFiles\\" + logo + "?"+d.getTime()+"' />");            
        }
               
    </script>
</asp:Content>
<asp:Content ID="MyContent2" ContentPlaceHolderID="nestedContent" runat="Server">
    <script type="text/javascript">

        $(document).ready(function () {
            limpiaMensajes();
            cargaImagen();

            //si aun no tiene empresa, que nomueste la opcion de subir logo, por qu elo necesito para crear la carpeta y guardarlo
            var empre = $("#<%=txtEmpre.ClientID%>").val();
            if (!validarVacio(empre)) {
                $(".cargaLogo").hide();
            }
            else
                $(".cargaLogo").show();

        });

        function limpiaMensajes() {
            $(".mensaje").hide();
        }

        function validar() {
            limpiaMensajes();
            var errores = 0;
            var user = $("#<%=txtUser.ClientID%>").val();
            var empre = $("#<%=txtEmpre.ClientID%>").val();
            var desc = $("#<%=txtDesc.ClientID%>").val();
            var logo = "";
            var web = $("#<%=txtWeb.ClientID%>").val();
            var mail = $("#<%=txtMail.ClientID%>");

            //user
            if (validarVacio(user)) {
                $("#<%=lblUserPon.ClientID%>").hide();
            }
            else {
                $("#<%=lblUserPon.ClientID%>").show();
                errores = 1;
            }

            //empre
            if (validarVacio(empre)) {
                $("#<%=lblEmprePon.ClientID%>").hide();
            }
            else {
                $("#<%=lblEmprePon.ClientID%>").show();
                errores = 1;
            }

            //valida mail
            if (!validarVacio(mail)) {
                if (validarEmail(mail)) {
                    $("#<%=lblCorreoMal.ClientID%>").hide();
                }
                else {
                    $("#<%=lblCorreoMal.ClientID%>").show();
                    errores = 1;
                }
            }

            if (errores == 0)
                guarda(user, desc, logo, web, mail, empre);

        }

        function guarda(user, desc, logo, web, mail, empre) {
            PageMethods.btnGuardar_onclick(user, desc, logo, web, mail.val(), empre, callBack);
        }

        function callBack(resutl) {
            var label;
            if (result = '1') {
                label = '<%=GetGlobalResourceObject("Globalresource", "guardar_exito" ) %> ';
                $(".cargaLogo").show();
                alertify.success(label);
            }
            else {
                label = '<%=GetGlobalResourceObject("Globalresource", "guardar_falla" ) %> ';
                alertify.error(label);
            }
        }

    </script>
    
    <table class="login">
        <tr>
            <td colspan="2" style="text-align: center;">
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
            </td>
            <td>
                <asp:Label ID="lblUserPon" runat="server" CssClass="errorPeque mensaje" Text='<%$ Resources:Globalresource, lbl_CampoObligatorio %>'></asp:Label>
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
            </td>
            <td>
                <asp:Label ID="lblEmprePon" runat="server" CssClass="errorPeque mensaje" Text='<%$ Resources:Globalresource, lbl_CampoObligatorio %>'></asp:Label>
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
                <asp:Label ID="lblCorreoMal" runat="server" CssClass="errorPeque mensaje" Text='<%$ Resources:Globalresource, lbl_CorreoMal %>'></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <div class="cargaLogo">
                    <asp:Literal ID="Literal3" runat="server" Text='<%$ Resources:Globalresource, lbl_LogoLocaliz %>'></asp:Literal></div>
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
        <tr>
            <td colspan="2" align="right">
                <input id="btnGuardar" class="botonStandar" runat="server" type="button" value='<%$ Resources:Globalresource, btn_Guardar %>'
                    onclick="javascript:validar();" />
            </td>
        </tr>
    </table>
    <div class="growlUI" style="display: none">
        <h1>
            Growl Notification</h1>
        <h2>
            Have a nice day!</h2>
    </div>  
</asp:Content>
