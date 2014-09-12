using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Web.Services;

public partial class Admin_Sucursales : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user"] == null)
        {
            Response.Redirect("../Start/Inicio.aspx", false);
        }
        if (!IsPostBack)
        {
            Limpiar();
            cargaRedesSociales();           
        }      
    }

    public void Limpiar()
    {
        txtNomSuc.Text = txtDom.Text = txtDom.Text = String.Empty;        
    }

    public void cargaRedesSociales()
    {
        div_redesS.Controls.Clear(); 
        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
        DataTable dt = null;
        try
        {
            dt = DataAccess.executeStoreProcedureDataTable("spr_GET_RedesSociales", parameters);
        }
        catch (Exception ex) { }
        if (dt != null && dt.Rows.Count > 0)
        {
            string cad = "<table>";
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                cad += "<tr>";
                //logo
                cad += "<td style=\"width:65px;\">";
                cad += "<img src=\"" + dt.Rows[i]["logoRedS"].ToString() + "\" height=\"25\" width=\"25\">";
                cad += "</td>";                
                cad += "<td>";
                cad += "<input name= \"red_" + dt.Rows[i]["idRedS"].ToString() + "\" class=\"cajaLarga\">";
                cad += "</td>";

                cad += "</tr>";
            }
            cad += "</table>";

            LiteralControl menu = new LiteralControl(cad);
            div_redesS.Controls.Add(menu);
        }
    }
    /*
    public static void cargaDatosSucursales()
    {
        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
        parameters.Add("idCorreo", HttpContext.Current.Session["findOut"].ToString());
        DataSet dt = null;
        try
        {
            dt = DataAccess.executeStoreProcedureDataSet("spr_GET_SucursalesNombre", parameters);
        }
        catch (Exception ex) { }
        if (dt != null && dt.Tables[0].Rows.Count > 0)
        {
            grdSucursales.DataSource = dt.Tables[0];
            grdSucursales.DataBind();
        }
    }
    */

    [WebMethod]
    public static string cargaRedesSocialesWM()
    {        
        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
        DataTable dt = null;
        string cad = "";
        try
        {
            dt = DataAccess.executeStoreProcedureDataTable("spr_GET_RedesSociales", parameters);
        }
        catch (Exception ex) { }
        if (dt != null && dt.Rows.Count > 0)
        {
            cad = "<table>";
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                cad += "<tr>";
                //logo
                cad += "<td style=\"width:65px;\">";
                cad += "<img src=\"" + dt.Rows[i]["logoRedS"].ToString() + "\" height=\"25\" width=\"25\">";
                cad += "</td>";
                cad += "<td>";
                cad += "<input name= \"red_" + dt.Rows[i]["idRedS"].ToString() + "\" class=\"cajaLarga\">";
                cad += "</td>";

                cad += "</tr>";
            }
            cad += "</table>";             
        }
        return cad;
    }

    [WebMethod]
    public static int btnIniciarControl_onclick(string suc, string dir, string longi, string lati, string telefonos, string wats)
    {
        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
        parameters.Add("idUser", HttpContext.Current.Session["findOut"].ToString());
        parameters.Add("suc", suc.Trim());
        parameters.Add("dir", dir.Trim());
        parameters.Add("longi", longi.Trim());
        parameters.Add("lati", lati.Trim());
        parameters.Add("telefonos", telefonos.Trim());
        parameters.Add("whats", wats.Trim());

        int result = 0;
        try
        {
            result = DataAccess.executeStoreProcedureGetInt("spr_INSERT_Sucursal", parameters);
        }
        catch (Exception ex) { }
        return result;
    }

    #region grid
    protected void grdSucursales_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        switch (e.Row.RowType)
        {
            case DataControlRowType.DataRow:
                GridViewRow row = e.Row;
                Image img = e.Row.FindControl("img") as Image;
                if (row.RowIndex > -1)
                {
                    img.ImageUrl = "../img/pin.png"; //Aqui asignas la imagen dependiendo de lo que necesitas
                }
                break;
        }
    }
    #endregion

}