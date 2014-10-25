using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
using System.IO;

public partial class SendPass : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static void btnIniciar_onclick(string mail)
    {
        //sacar pass
        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
        parameters.Add("@mail", mail);
        string pass = DataAccess.executeStoreProcedureString("spr_GET_Pass", parameters);
        if (!String.IsNullOrEmpty(pass))
        {
            try
            {
                var pv = new Dictionary<string, string>();
                var files = new Dictionary<string, Stream>();

                Common.SendMailByDictionary(pv, files, /*mail*/"mmorfin7@hotmail.com", "MandarPass", pass);
                HttpContext.Current.Session["passEnviadoBien"] = "true";
            }
            catch (Exception ex)
            {
                HttpContext.Current.Session["passEnviadoBien"] = "false";
            }
        }
        else
        {
            HttpContext.Current.Session["passEnviadoBien"] = "noEncontrado";
        }
    }    
}