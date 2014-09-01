using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;

public partial class Admin_Localizacion : System.Web.UI.Page
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
            cargarDatos();
        }
    }

    public void Limpiar()
    {
        txtEmpre.Text= txtDesc.Text = txtUser.Text = txtLogo.Text = txtMail.Text = txtWeb.Text = String.Empty;
    }

    public void cargarDatos(){
        if (Session["findOut"] == null)
        {
            Response.Redirect("../Start/Inicio.aspx", false);
        }
        else
        {
            grdSucursales.DataSource = null;
            grdSucursales.DataBind(); 
            cargaDatosEmpresa();
        }
    }
    public void cargaDatosEmpresa()
    {
        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
        parameters.Add("idCorreo", Session["findOut"].ToString());
        DataSet dt = null;
        try
        {
            dt = DataAccess.executeStoreProcedureDataSet("spr_GET_InfoUser", parameters);
        }
        catch (Exception ex) { }
        if (dt != null && dt.Tables[0].Rows.Count > 0)
        {
            txtDesc.Text = dt.Tables[0].Rows[0]["desc"].ToString();
            txtUser.Text = dt.Tables[0].Rows[0]["user"].ToString();
            txtMail.Text = dt.Tables[0].Rows[0]["mail"].ToString();
            txtWeb.Text = dt.Tables[0].Rows[0]["web"].ToString();
            txtEmpre.Text = dt.Tables[0].Rows[0]["empresa"].ToString();
        }

        if (dt != null && dt.Tables[1].Rows.Count > 0)
        {
            grdSucursales.DataSource = dt.Tables[1];
            grdSucursales.DataBind();
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

    [WebMethod]
    public static int btnIniciar_onclick(string user, string desc, string logo, string web, string mail, string empre)
    {
        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
        parameters.Add("idCorreo", HttpContext.Current.Session["findOut"].ToString());
        parameters.Add("newUser", user.Trim());
        parameters.Add("desc", desc.Trim());
        parameters.Add("web", web.Trim());
        parameters.Add("mail", mail.Trim());
        parameters.Add("logo", logo.Trim());
        parameters.Add("empresa", empre.Trim());
        int result = 0;
        try
        {
            result = DataAccess.executeStoreProcedureGetInt("spr_INSERT_InfoUser", parameters);
        }catch(Exception ex){}
        return result;
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
        sucursal1.show();
    }
}
