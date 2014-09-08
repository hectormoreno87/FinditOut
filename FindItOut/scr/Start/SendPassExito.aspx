<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageLogin.master" AutoEventWireup="true"
    CodeFile="SendPassExito.aspx.cs" Inherits="SendPassExito" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Scripts/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="../Scripts/Validaciones.js" type="text/javascript"></script>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<br />
<br />
<br />
<br />
    <table  class="tabla_sola" >
        <tr>
            <td style="text-align: center;" class="titulo_tabla">
                <asp:Literal ID="lblTitulo" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Literal ID="lblMesg" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td style="word-wrap: break-word; width: 200px;">
                <asp:Literal ID="lblCorreo1" runat="server"></asp:Literal>
                <h3>
                    <asp:Literal ID="lblMail" runat="server"></asp:Literal>
                </h3>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Literal ID="lblCorreo2" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td align="right" style="text-align:right;">
                <asp:LinkButton CssClass="link" ID="lnkSenPass" runat="server" PostBackUrl="SendPass.aspx"
                    Text='<%$ Resources:Globalresource, link_regresaSendPass %>'></asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td align="right" style="text-align:right;">
                <asp:LinkButton CssClass="link" ID="lnkInicio" runat="server" PostBackUrl="Inicio.aspx"
                    Text='<%$ Resources:Globalresource, link_irLogin %>'></asp:LinkButton>
            </td>
        </tr>  
    </table>
</asp:Content>
