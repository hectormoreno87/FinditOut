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
        txtDesc.Text = txtUser.Text = String.Empty;
    }

    public void cargarDatos(){
        if (Session["findOut"] == null)
        {
            Response.Redirect("../Start/Inicio.aspx", false);
        } 
        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>(); 
        parameters.Add("idCorreo", Session["findOut"].ToString());
        DataTable dt = null;
        try
        {
            dt = DataAccess.executeStoreProcedureDataTable("spr_GET_InfoUser", parameters);
        }
        catch (Exception ex) { }
        if (dt != null && dt.Rows.Count > 0)
        {
            txtDesc.Text = dt.Rows[0]["desc"].ToString();
            txtUser.Text = dt.Rows[0]["user"].ToString();
        }
    }

    [WebMethod]
    public static int btnIniciar_onclick(string user, string desc, string  dom, string  lati, string  longi, string  tel)
    {
        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
        parameters.Add("idCorreo", HttpContext.Current.Session["findOut"].ToString());
        parameters.Add("newUser", user.Trim());
        parameters.Add("desc", desc.Trim());
        //parameters.Add("dom", dom.Trim());
        //parameters.Add("lati", lati.Trim());
        //parameters.Add("longi", longi.Trim());
        //parameters.Add("tel", tel.Trim());
        int result = 0;
        try
        {
            result = DataAccess.executeStoreProcedureGetInt("spr_INSERT_InfoUser", parameters);
        }catch(Exception ex){}
        return result;
    }
}
