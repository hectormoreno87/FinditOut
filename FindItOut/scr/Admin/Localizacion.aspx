<%@ Page Title="" Language="C#" MasterPageFile="Admin.master" AutoEventWireup="true"
    CodeFile="Localizacion.aspx.cs" Inherits="Admin_Localizacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Scripts/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="../Scripts/Validaciones.js" type="text/javascript"></script>
    <link href="../Styles/StyleSheet.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function validar() {
            var user = $("#<%=txtUser.ClientID%>").val();
            var desc = $("#<%=txtDesc.ClientID%>").val();
            var dom = $("#<%=txtDom.ClientID%>").val();
            var lati = $("#<%=txtLatitud.ClientID%>").val();
            var longi = $("#<%=txtLongitud.ClientID%>").val();
            var tel = $("#<%=txtTel.ClientID%>").val();
            PageMethods.btnIniciar_onclick(user, desc, dom, lati, longi, tel, callBack);
        }

        function callBack(resutl) {
            if (result = '1')
                alert('Guadado');
            else
                alert('No guardado :(');
        }
    </script>
    <table >
        <tr>
            <td>
                <asp:Literal ID="Literal2" runat="server" Text='<%$ Resources:Globalresource, lbl_UserLocaliz %>'></asp:Literal>
            </td>
            <td>
                <asp:TextBox ID="txtUser" runat="server" MaxLength="50" CssClass="cajaLarga"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Literal ID="Literal1" runat="server" Text='<%$ Resources:Globalresource, lbl_UserExpLocaliz %>'></asp:Literal>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Literal ID="Literal4" runat="server" Text='<%$ Resources:Globalresource, lbl_DescrLocaliz %>'></asp:Literal>
            </td>
            <td>
                <asp:TextBox ID="txtDesc" runat="server" MaxLength="250" CssClass="cajaLarga" TextMode="MultiLine"
                    onkeypress=" return limita(this, event,250)" onkeyup="cuenta(this, event,250)"
                    onchange="limita(this, event,250)"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Literal ID="Literal5" runat="server" Text='<%$ Resources:Globalresource, lbl_DomLocaliz %>'></asp:Literal>
            </td>
            <td>
                <asp:TextBox ID="txtDom" runat="server" MaxLength="100" CssClass="cajaLarga" TextMode="MultiLine"
                    onkeypress=" return limita(this, event,100)" onkeyup="cuenta(this, event,100)"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Literal ID="Literal3" runat="server" Text='<%$ Resources:Globalresource, lbl_latitud %>'></asp:Literal>
            </td>
            <td>
                <asp:TextBox ID="txtLatitud" runat="server" MaxLength="20" CssClass="cajaLarga"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Literal ID="Literal7" runat="server" Text='<%$ Resources:Globalresource, lbl_longitud %>'></asp:Literal>
            </td>
            <td>
                <asp:TextBox ID="txtLongitud" runat="server" MaxLength="20" CssClass="cajaLarga"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Literal ID="Literal6" runat="server" Text='<%$ Resources:Globalresource, lbl_TelLocaliz %>'></asp:Literal>
            </td>
            <td>
                <asp:TextBox ID="txtTel" runat="server" MaxLength="20" CssClass="cajaLarga"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="right">
                <input id="btnIniciar" class="botonStandar" runat="server" type="button" value='<%$ Resources:Globalresource, btn_Guardar %>'
                    onclick="javascript:validar();" />
            </td>
        </tr>
    </table>
</asp:Content>
