using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;

public partial class Inicio : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //pruebas
        txtMail.Text = "m@hotmail.com";
        txtPass.Text = "123";
        Session["user"] =
            Session["err"] =
            Session["correoEnviar"] =
            Session["findOut"] =
            null;

    }

    [WebMethod]
    public static void btnIniciar_onclick(string mail, string pass)
    {

        //HttpContext.Current.Session["user"] = "1";
        //return;
        if (validar( mail,  pass))
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
                    HttpContext.Current.Session["user"] = null;
                    if (result == "puedePasar")
                    {
                        HttpContext.Current.Session["user"] = dt.Rows[0]["nikname"].ToString().Trim();
                        HttpContext.Current.Session["findOut"] = dt.Rows[0]["findOut"].ToString().Trim();
                        HttpContext.Current.Session["idEmpresa"] = dt.Rows[0]["idEmpresa"].ToString().Trim();
                    }
                }
            }
            catch (Exception ex) {
            
            
            }
        }
    }

    public static bool validar(string mail, string pass)
    {
        bool pasa = false;
        //validar correo
        if (!String.IsNullOrEmpty(mail))
        {
            if (mail.Trim().Length < 101 && mail.Trim().Length > 0)
            {
                if (Common.IsValidEmail(mail))
                {
                    pasa = true;
                }
                else pasa = false;
            }
            else pasa = false;
        }
        else pasa = false;
          
        if (!String.IsNullOrEmpty(pass))
        {
            if (pass.Trim().Length < 16 && pass.Trim().Length > 0)
            {
                pasa = true;
            }
            else pasa = false;
        }
        else pasa = false;
        return pasa;
    }
}