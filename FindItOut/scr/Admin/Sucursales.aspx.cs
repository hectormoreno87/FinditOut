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
            cargaDatos();
        }

        if (this.Request.Files.Count > 0)
        {
            File.Delete(Server.MapPath("~") + "\\img\\FindOut\\FindItOutName\\Item\\filename2.jpg");

            this.Request.Files[0].SaveAs(Server.MapPath("~") + "\\img\\FindOut\\FindItOutName\\Item\\filename2.jpg");
        }
        //this.respuesta.InnerHtml = "respuasdasesta";
    }

    public void Limpiar()
    {
       
    }

    public void cargaDatos()
    {
        if (Session["findOut"] == null)
        {
            Response.Redirect("../Start/Inicio.aspx", false);
        }
        else
        {
            grdSucursales.DataSource = null;
            grdSucursales.DataBind();
            Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
            parameters.Add("idCorreo", Session["findOut"].ToString());
            DataTable dt = null;
            try
            {
                dt = DataAccess.executeStoreProcedureDataTable("spr_GET_InfoUserSucursales", parameters);
            }
            catch (Exception ex) { }
            
            if (dt != null && dt.Rows.Count > 0)
            {
                grdSucursales.DataSource = dt;
                grdSucursales.DataBind();
            }
        }
    }

    public static void cargaDatosSucursales()
    {
        /*Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
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
        }*/
    }

    [WebMethod]
    public static int btnIniciarControl_onclick(string suc, string dir, string longi, string lati, string telefonos, string wats)
    {
        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
        parameters.Add("idCorreo", HttpContext.Current.Session["findOut"].ToString());
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


    protected void btnNueva_Click(object sender, ImageClickEventArgs e)
    {
       // sucursal1.show();
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