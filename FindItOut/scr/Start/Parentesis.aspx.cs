using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Parentesis : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //-----------------esto viene de la pagina de error en login
        if (Session["err"] != null && !String.IsNullOrEmpty(Session["err"].ToString()))
        {
            string error = Session["err"].ToString();            

            if (error != "puedePasar")
            {
                Response.Redirect("ErrorLog.aspx", false);
            }
            else if (error == "puedePasar")
            {
                Response.Redirect("~/Admin/Localizacion.aspx", false);
            }
        }

        //---------------esto viene de la pagina de crear cuenta
        else if ( (Session["resp"] != null && !String.IsNullOrEmpty(Session["resp"].ToString()))
             &&
             (Session["correoEnviar"] != null && !String.IsNullOrEmpty(Session["correoEnviar"].ToString()))            
            )
        {
            
            Response.Redirect("Registro1Exito.aspx", false); 
        }

        //---------------esto viene enviar pass de recuperacion
        else if (Session["passEnviadoBien"] != null && !String.IsNullOrEmpty(Session["passEnviadoBien"].ToString()))
        {            
            Response.Redirect("SendPassExito.aspx", false);           
        }
        
    }

    //public void redireccionar()
    //{
    //    HttpContext.Current.Session["err"] = "errorMail";
    //    string url = "ErrorLog.aspx";
    //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "temp", "<script type='text/javascript'>redirigir('" + url + "');</script>", false);
    //    // HttpContext.Current.Response.Redirect("~/ErrorLog.aspx", false);
    //}
}