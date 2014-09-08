using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;
using System.IO;
using System.Configuration;

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
            cargaDatos();
        }

        //if (this.Request.Files.Count > 0)
        //{
        //    File.Delete(Server.MapPath("~") + "\\img\\FindOut\\FindItOutName\\Item\\filename2.jpg");

        //    this.Request.Files[0].SaveAs(Server.MapPath("~")+"\\img\\FindOut\\FindItOutName\\Item\\filename2.jpg");
        //}
        //this.respuesta.InnerHtml = "respuasdasesta";
     
    }

    public void Limpiar()
    {
        txtEmpre.Text= txtDesc.Text = txtUser.Text = /*txtLogo.Text =*/ txtMail.Text = txtWeb.Text = String.Empty;
    }

    public void cargaDatos()
    {
        if (Session["findOut"] == null)
        {
            Response.Redirect("../Start/Inicio.aspx", false);
        }
        else
        {
            Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
            parameters.Add("idUser", Session["findOut"].ToString());
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
                txtMail.Text = dt.Rows[0]["mail"].ToString();
                txtWeb.Text = dt.Rows[0]["web"].ToString();
                txtEmpre.Text = dt.Rows[0]["empresa"].ToString();
            }

            if (!String.IsNullOrEmpty(txtEmpre.Text))
            {
                txtEmpre.Enabled = false;
            }
            
        }
    }
    
    [WebMethod]
    public static int btnGuardar_onclick(string user, string desc, string logo, string web, string mail, string empre)
    {
        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
        parameters.Add("idUser", HttpContext.Current.Session["findOut"].ToString());
        int result = 0;
        string carpeta = String.Empty;

        //revisar en BD si el cliente tiene carpeta
        try
        {
            carpeta = DataAccess.executeStoreProcedureString("spr_Get_InfoLogo", parameters);
        }
        catch (Exception ex) { }
        
        if (String.IsNullOrEmpty( carpeta ) ) //no tiene
             carpeta = creaCarpeta(empre);

        parameters.Add("newUser", user.Trim());
        parameters.Add("desc", desc.Trim());
        parameters.Add("web", web.Trim());
        parameters.Add("mail", mail.Trim());
        parameters.Add("logo", carpeta.Trim());
        parameters.Add("empresa", empre.Trim());

        try
        {
            result = DataAccess.executeStoreProcedureGetInt("spr_INSERT_InfoUser", parameters);
        }catch(Exception ex){}
        return result;
    }

    [WebMethod]
    public static string creaCarpeta(string empre)
    {
        //empre = "   Maritza de JesusMorfin Franco ";
        string carpeta = empre.Replace(" ","") + "-" + Common.GetSHA1(DateTime.Now.ToString());

       //crear carpeta principal
        string PathDocs = ConfigurationManager.AppSettings["EmpresasFiles"];
        string inicio = HttpContext.Current.Server.MapPath(PathDocs);
        try
        {
            if (!System.IO.Directory.Exists(inicio))
                System.IO.Directory.CreateDirectory(inicio);
        }
        catch (Exception ex)
        {
        }

        //crear carpeta cliente
        string carpetaCliente = inicio+carpeta;
        try
        {
            if (!System.IO.Directory.Exists(carpetaCliente))
                System.IO.Directory.CreateDirectory(carpetaCliente);
        }
        catch (Exception ex)
        {
        }
        return carpeta;
    }
}
