<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageLogin.master" AutoEventWireup="true" CodeFile="ConfirmarCuenta.aspx.cs" Inherits="Start_ConfirmarCuenta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script src="../Scripts/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="../Scripts/Validaciones.js" type="text/javascript"></script>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <table>
        <tr>
            <td class="titulo_tabla"; style="text-align: center;">
                
                    <asp:Literal ID="lblBienvenida" runat="server"></asp:Literal>
                
            </td>
        </tr>        
        <tr>
            <td style="word-wrap: break-word; width: 200px;">
                <asp:Literal ID="lblMessg" runat="server"></asp:Literal>
            </td>
        </tr>                
        <tr>
            <td align="right" style="text-align:right;">
                <asp:LinkButton ID="LinkButton2" runat="server" CssClass="link" PostBackUrl="Inicio.aspx"
                    Text='<%$ Resources:Globalresource, link_irLogin %>'></asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td align="right" style="text-align:right;">
                <asp:LinkButton CssClass="link" ID="linkOlvidePass" runat="server" Text='<%$ Resources:Globalresource, link_OlvidePass %>'
                    PostBackUrl="SendPass.aspx"></asp:LinkButton>
            </td>
        </tr>
    </table>
</asp:Content>

