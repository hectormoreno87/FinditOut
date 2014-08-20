<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageLogin.master" AutoEventWireup="true"
    CodeFile="Registro1Exito.aspx.cs" Inherits="Registro1Exito" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

 <table class="login">
        <tr>
            <td class="titulo_tabla" style="text-align: center; ">
            
                    <asp:Literal ID="lblTitulo" runat="server" Text='<%$ Resources:GlobalResource, Bienvenida_Registro1Exito%>'></asp:Literal>
             
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
                <asp:LinkButton CssClass="link" ID="lnkInicio" runat="server" PostBackUrl="Inicio.aspx"
                    Text='<%$ Resources:Globalresource, link_irLogin %>'></asp:LinkButton>
                <asp:LinkButton CssClass="link" ID="lnkRegistro" runat="server" PostBackUrl="Registro1.aspx"
                    Text='<%$ Resources:Globalresource, link_regresarRegistro %>'></asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td align="right" style="text-align:right;">
                <asp:LinkButton CssClass="link" ID="lnkRecordarPass" runat="server" PostBackUrl="SendPass.aspx"
                    Text='<%$ Resources:Globalresource, link_OlvidePass %>'></asp:LinkButton>
            </td>
        </tr>
    </table>
</asp:Content>
