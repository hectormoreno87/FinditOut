using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Web.Services;
using System.Configuration;

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
        string carpeta = String.Empty;
        int result = 0;

        //checar que exista la carpeta de la empresa, que para estas alturas debe de tener,, pero por si acaso            
        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
        parameters.Add("idUser", HttpContext.Current.Session["findOut"].ToString());
        try
        {
            carpeta = DataAccess.executeStoreProcedureString("spr_Get_InfoLogo", parameters);
        }
        catch (Exception ex) { }


        if (String.IsNullOrEmpty(carpeta)) //no tiene carpeta la empresa
        { 
            result = -1; 
        }
        else
        {
            //revisar si tiene carpeta de "sucursales", sino, crearla
            string PathDocs = ConfigurationManager.AppSettings["EmpresasFiles"];
            string inicio = HttpContext.Current.Server.MapPath(PathDocs);
            string carpSuc = ConfigurationManager.AppSettings["CarpetaSucursales"];
            string resp = Common.creaCarpetaSucursales(carpeta, inicio, carpSuc);

            if (String.IsNullOrEmpty(resp))//todo bien
            {
                parameters.Clear();
                parameters.Add("idUser", HttpContext.Current.Session["findOut"].ToString());
                parameters.Add("suc", suc.Trim());
                parameters.Add("dir", dir.Trim());
                parameters.Add("longi", longi.Trim());
                parameters.Add("lati", lati.Trim());
                parameters.Add("telefonos", telefonos.Trim());
                parameters.Add("whats", wats.Trim());

                try
                {
                    result = DataAccess.executeStoreProcedureGetInt("spr_INSERT_Sucursal", parameters);
                }
                catch (Exception ex) { }

            }
            else
            {
                result = 0;
            }

        }
        return result;
    }

  

}