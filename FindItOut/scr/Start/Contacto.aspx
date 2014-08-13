<%@ Page Title="" Language="C#" MasterPageFile="~/Start/MasterPageLogin.master" AutoEventWireup="true" CodeFile="Contacto.aspx.cs" Inherits="Start_Contacto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <link href="../Styles/StyleSheet0.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table>
        <tr>
            <td class="titulo_tabla" style="text-align: center;">
            
                    <asp:Literal ID="lblTitulo" runat="server" Text='<%$ Resources:GlobalResource, Bienvenida_Contacto%>'></asp:Literal>
             
            </td>
        </tr>
        <tr>
            <td style="word-wrap: break-word; width: 200px;">
                <asp:Literal ID="lbl_MssgContacto" runat="server" Text='<%$ Resources:GlobalResource, lbl_MssgContacto%>'></asp:Literal>                
            </td>
        </tr>
        <tr>
            <td>
                <asp:Literal ID="lblComentarioContacto" runat="server" Text='<%$ Resources:GlobalResource, lblComentarioContacto%>'></asp:Literal>
            </td>
        </tr>
        <tr>
        <td align="center" style="text-align:center;">
            <asp:TextBox ID="txtComentario" runat="server" TextMode="MultiLine" Height="100px" Width="95%"></asp:TextBox>
        </td>
        </tr>
        <tr>
            <td>
                <asp:Literal ID="Literal1" runat="server" Text='<%$ Resources:GlobalResource, lblCorreoContacto%>'></asp:Literal>
            </td>
        </tr>
        <tr>
        <td align="center" style="text-align:center;">
            <asp:TextBox ID="txtCorreo" runat="server" CssClass="cajaLarga"></asp:TextBox>
        </td>
        </tr>
        <tr>
        <td style="text-align:right;">
            <asp:Button CssClass="botonStandar" ID="btnEnviar" runat="server" Text='<%$ Resources:GlobalResource, btn_EnviarPass%>' />
        </td>
        </tr>
    </table>
</asp:Content>

