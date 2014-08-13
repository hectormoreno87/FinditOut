using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;

public partial class ErrorLog : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["err"] == null)
        {
            Response.Redirect("Inicio.aspx", false);
        }
        else
        {
            string error = Session["err"].ToString();
            Session["err"] = null;

            if (error == "errorMail")//
            {
                lblTipoError.Text = Resources.GlobalResource.lbl_DireccionInvalida;
                lblDescError.Text = Resources.GlobalResource.lbl_DireccionInvalida2;
            }
            else if (error == "errorPass")//
            {
                lblTipoError.Text = Resources.GlobalResource.lbl_PassInvalido;
                lblDescError.Text = Resources.GlobalResource.lbl_PassInvalido2;
            }
            else if (error == "inactivo")//
            {
                lblTipoError.Text = Resources.GlobalResource.lbl_inactivo;
                lblDescError.Text = Resources.GlobalResource.lbl_inactivo2;
            }
            else if (error == "sinConfirmar")
            {
                lblTipoError.Text = Resources.GlobalResource.lbl_sinConfirmar;
                lblDescError.Text = Resources.GlobalResource.lbl_sinConfirmar2;
            }
        }
    }

    [WebMethod]
    public static void btnIniciar_onclick(string mail, string pass)
    {
        //revisar que los datos existan
        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
        parameters.Add("@mail", mail);
        parameters.Add("@pass", pass);
        DataTable dt = null;
        dt = DataAccess.executeStoreProcedureDataTable("spr_GET_IniciarSesion", parameters);
        try
        {
            if (dt != null && dt.Rows.Count > 0)
            {
                string result = dt.Rows[0]["result"].ToString();
                HttpContext.Current.Session["err"] = result;
                if (result == "puedePasar")
                {
                    HttpContext.Current.Session["user"] = dt.Rows[0]["nikname"].ToString();
                }
            }
        }
        catch (Exception ex) { }
    }    
}