using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;
using System.IO;

public partial class Registro1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    [WebMethod]
    public static int btnCrearCuenta_onclick(string mail, string pass, string confirm)
    {       
        //se vuelven a hacer validadiones, por si acaso
        int valor = pass.CompareTo(confirm);        
        if (valor != 0)//son diferentes
        {
        }
        else
        {
            Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
            parameters.Add("@mail", mail);
            parameters.Add("@pass", pass);

            DataTable dt = null;
            dt = DataAccess.executeStoreProcedureDataTable("spr_INSERT_Usuario", parameters);

            if (dt != null && dt.Rows.Count > 0)
            {
                string result = dt.Rows[0]["result"].ToString();
                if (result == "yaExiste")
                {
                    HttpContext.Current.Session["resp"] = "1";
                    HttpContext.Current.Session["correoEnviar"] = "x";
                    valor = 1;
                }         
                else if (result == "guardado")
                {
                    //mandar correo 
                    HttpContext.Current.Session["correoEnviar"] = mail;
                    HttpContext.Current.Session["resp"] = "3"; 
                    try
                    {
                        var pv = new Dictionary<string, string>();
                        var files = new Dictionary<string, Stream>();

                        mail = Common.codifica(mail);
                        pass = Common.codifica(pass);
                        string id = Common.codifica(dt.Rows[0]["llave"].ToString());

                        Common.SendMailByDictionary(pv, files, /*mail*/"maritza.morfin@dominio6.com", "preAprobada", mail, pass, id);
                        
                    }
                    catch (Exception ex)
                    {
                      
                    }
                   
                }
            }
        }
        return valor;
    }
}