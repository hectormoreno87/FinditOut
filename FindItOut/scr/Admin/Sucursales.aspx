<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterAdmin.master" AutoEventWireup="true" CodeFile="Sucursales.aspx.cs" Inherits="Admin_Sucursales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Myhead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="nestedContent" Runat="Server">

 <table class="login">
        <tr>
            <td style="text-align: center;">
                <h2>
                    <asp:Literal ID="Literal1" runat="server" Text='<%$ Resources:Globalresource, lbl_MisSucursales %>'></asp:Literal></h2>
            </td>
        </tr>
        <tr>
            <td align="right" style="text-align: right;">
                <asp:Literal ID="Literal8" runat="server" Text='<%$ Resources:Globalresource, lbl_MisSucursalesNuevo %>'></asp:Literal>
                <asp:ImageButton ID="btnNueva" runat="server" ImageUrl="../img/pinMas.png" Width="25px"
                    ToolTip='<%$ Resources:Globalresource, lbl_MisSucursalesNuevo %>' OnClick="btnNueva_Click" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="grdSucursales" runat="server" DataKeyNames="idSuc" CssClass="gridViewChico"
                    AutoGenerateColumns="False" OnRowDataBound="grdSucursales_RowDataBound">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Image ID="img" runat="server" CausesValidation="False" Width="15px"></asp:Image>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="suc" />
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>

</asp:Content>

