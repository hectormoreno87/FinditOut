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
using System.Drawing;
using log4net;
using System.Web.Script.Serialization;

public partial class Admin_Localizacion : System.Web.UI.Page
{
    private static readonly ILog log = LogManager.GetLogger(typeof(Admin_Localizacion));
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user"] == null)
        {
            Response.Redirect("../Start/Inicio.aspx", false);
        }
        if (!IsPostBack)
        {
           // Limpiar();
            cargaDatos();
        }
        else
        {

            if (Request.RequestType == "POST"&&isImage())
            {
                Response.Clear();
                Response.ContentType = "application/json";
                ResponseClass r = new ResponseClass();

                if (guardaImagen())
                {
                    //this.resultImage.Value = "<img src=\"../img/FindOut/"+this.Session["idEmpresa"].ToString()+"/logo.png\">";
                    r.Result = "1";
                    r.Data = "<img src='../img/FindOut/" + this.Session["idEmpresa"].ToString() + "/logo.png?d=" + ((int)DateTime.Now.Second) + "'>";
                    var json = new JavaScriptSerializer().Serialize(r);
                  //  JSON.Parse("{number:1000, str:'string', array: [1,2,3,4,5,6]}");
                    //Response.Write("{\"success\": false, \"message\": \"Error al guardar los datos\"}");
                   Response.Write(json);
                    
                }
                else
                {

                    this.resultImage.Value = "0";
                    r.Result = "0";
                    r.Data = "";
                    var json = new JavaScriptSerializer().Serialize(r);
                    Response.Write(json);
                    
 
                }

                
                Response.End();
            }
        }
    }

    public bool isImage()
    {
        bool b = false;

        foreach (string s in this.Request.Form.AllKeys)
        {
            if (s == "IMAGEN")
            {
                b = true;
                return b;
            }
        }
        return b;
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
            
            if (dt != null && dt.Rows.Count > 0)
            {
                txtDesc.Text = dt.Rows[0]["desc"].ToString();
                txtUser.Text = dt.Rows[0]["user"].ToString();
                txtMail.Text = dt.Rows[0]["mail"].ToString();
                txtWeb.Text = dt.Rows[0]["web"].ToString();
                txtEmpre.Text = dt.Rows[0]["empresa"].ToString();
                //muestraLogo( dt.Rows[0]["logo"].ToString() );
            }

            }
            catch (Exception ex) 
            {
                log.Error(ex);
            }
            ////if (!String.IsNullOrEmpty(txtEmpre.Text))
            ////{
            ////    txtEmpre.Enabled = false;
            ////}
            
        }
    }
    
    public void muestraLogo(string logo)
    {
        ClientScript.RegisterStartupScript(GetType(), "algo", "callBackSacaImagen("+logo+")" , true);
    }
    
    [WebMethod]
    public static string sacaImagen()
    {
        if (HttpContext.Current.Session["findOut"].ToString() == null)
        {
            HttpContext.Current.Response.Redirect("../Start/Inicio.aspx", false);
            return "";
        }
        else
        {
            //Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
            //parameters.Add("idUser", HttpContext.Current.Session["findOut"].ToString());
            //string carpeta = String.Empty;

            ////revisar en BD si el cliente tiene carpeta
            //try
            //{
            //    carpeta = DataAccess.executeStoreProcedureString("spr_Get_InfoLogo", parameters);
            //}
            //catch (Exception ex) 
            //{ 
            
            //}

            //if (!String.IsNullOrEmpty(carpeta))
            //{
            //    //buscar el directorio
            //    string PathDocs = ConfigurationManager.AppSettings["EmpresasFiles"];
            //    string inicio = HttpContext.Current.Server.MapPath(PathDocs);
            //    string carpLogo = ConfigurationManager.AppSettings["CarpetaLogo"];
            //    carpeta = carpeta + "\\" + carpLogo;
            //    string directorioFisico = inicio + carpeta;

            if (HttpContext.Current.Session["idEmpresa"].ToString() != "0")
            {
                try
                {
                    if (System.IO.File.Exists(HttpContext.Current.Server.MapPath("~\\img\\FindOut\\" + HttpContext.Current.Session["idEmpresa"].ToString() + "\\logo.png")))
                    {
                        return "..\\img\\FindOut\\" + HttpContext.Current.Session["idEmpresa"].ToString() + "\\logo.png";
                    }
                    else 
                    {
                        return "noLogo";
                    }
                }
                catch (Exception ex)
                {
                    return "error";
                    log.Error(ex);
                }

            }
            else {
                return "noEmpresa";
            }
         //   }
           
        }
    }
   
 
    [WebMethod]
    public static int btnGuardar_onclick(string user, string desc, string logo, string web, string mail, string empre)
    {
        if (HttpContext.Current.Session["findOut"].ToString() == null)
        {
            HttpContext.Current.Response.Redirect("../Start/Inicio.aspx", false); 
            return 0;
        }
        else
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

            if (String.IsNullOrEmpty(carpeta)) //no tiene carpeta la empresa
                carpeta = creaCarpeta(empre);

            parameters.Add("newUser", user.Trim());
            parameters.Add("desc", desc.Trim());
            parameters.Add("web", web.Trim());
            parameters.Add("mail", mail.Trim());
            parameters.Add("carpeta", carpeta.Trim());
            parameters.Add("empresa", empre.Trim());

            try
            {
                result = DataAccess.executeStoreProcedureGetInt("spr_INSERT_InfoUser", parameters);
            }
            catch (Exception ex) { }
            return result;
        }
    }

    [WebMethod]
    public static string creaCarpeta(string empre)
    {
        string PathDocs = ConfigurationManager.AppSettings["EmpresasFiles"];
        string inicio = HttpContext.Current.Server.MapPath(PathDocs);
        string carpSucu = ConfigurationManager.AppSettings["CarpetaSucursales"];
        string carpLogo = ConfigurationManager.AppSettings["CarpetaLogo"];
        string carpeta = Common.creaCarpetaEmpresa(empre, inicio, carpSucu, carpLogo);
        return carpeta;
        
    }

    public bool guardaImagen()
    {
        if (Session["user"] == null)
        {
            Response.Redirect("../Start/Inicio.aspx", false);
        }
        else
        {
            if ( /*this.*/Request.Files.Count > 0)
            {
                //Revisar que no este vacio el nombre del archivo:
                if (String.IsNullOrEmpty(Request.Files[0].FileName.ToString()))
                {
                    return false;
                } 
                
                //Dictionary<string, object> parameters = new Dictionary<string, object>();
                //parameters.Add("idUser", Session["findOut"].ToString());
                //string carpeta = String.Empty;
                
                ////revisar en BD si el cliente tiene carpeta
                //try
                //{
                //    carpeta = DataAccess.executeStoreProcedureString("spr_Get_InfoLogo", parameters);
                //}
                //catch (Exception ex) { }

                //ver si tiene carpeta
                //if (!String.IsNullOrEmpty(carpeta))
                //{
                    //buscar el directorio
                    string PathDocs = ConfigurationManager.AppSettings["EmpresasFiles"];
                    string inicio = HttpContext.Current.Server.MapPath(PathDocs);
                    string carpLogo = ConfigurationManager.AppSettings["CarpetaLogo"];
                   // carpeta = carpeta + "\\" + carpLogo;
                   // string directorioFisico = inicio + carpeta;
                    string directorioVirtual = "~\\img\\FindOut\\";
                   
                    try
                    {
                        //if (System.IO.Directory.Exists(directorioFisico))
                        //{
                            //si existe, borra el que habia
                        if (!System.IO.Directory.Exists(Server.MapPath("~\\img\\FindOut\\") + this.Session["idEmpresa"].ToString()+"\\logo.png"))
                                File.Delete(Server.MapPath("~\\img\\FindOut\\") + this.Session["idEmpresa"].ToString()+"\\logo.png");

                        if (!System.IO.Directory.Exists(Server.MapPath("~\\img\\FindOut\\") + this.Session["idEmpresa"].ToString()+"\\logoCh.png"))
                                File.Delete(Server.MapPath("~\\img\\FindOut\\") + this.Session["idEmpresa"].ToString()+"\\logoCh.png");

                            //cambiar tamaño
                            System.Drawing.Image originalImage = System.Drawing.Image.FromStream(Request.Files[0].InputStream, true, true);
                            //logo grande
                            System.Drawing.Image resizedImage = originalImage.GetThumbnailImage(160, 160, null, IntPtr.Zero);
                            //logo chico
                            System.Drawing.Image resizedImageCh = originalImage.GetThumbnailImage(50, 50, null, IntPtr.Zero);

                            //guarda el nuevo
                            //Request.Files[0].SaveAs(Server.MapPath(directorioVirtual) + carpeta + "\\logo.png" );
                            resizedImage.Save(Server.MapPath(directorioVirtual) + this.Session["idEmpresa"].ToString()+ "\\logo.png");
                            resizedImageCh.Save(Server.MapPath(directorioVirtual) + this.Session["idEmpresa"].ToString()+ "\\logoCh.png");
                    //    }
                    }
                    catch (Exception ex) {

                        log.Error(ex);
                    }
                //}
            }
        }
        return true;
    }
    protected void hidden_save_Click(object sender, EventArgs e)
    {
        try {


            Dictionary<string, object> parameters = new Dictionary<string, object>();
            if (Session["findOut"]!=null)
            parameters.Add("idUser", Session["findOut"].ToString());
            int result = 0;
            string carpeta = String.Empty;

            parameters.Add("newUser", this.txtUser.Text);
            parameters.Add("desc", this.txtDesc.Text);
            parameters.Add("web", this.txtWeb.Text);
            parameters.Add("mail", this.txtMail.Text);
            //parameters.Add("carpeta", this.txt);
            parameters.Add("empresa", this.txtEmpre.Text);
            result = DataAccess.executeStoreProcedureGetInt("spr_INSERT_EMPRESA", parameters);
            

            if (this.Session["idEmpresa"].ToString() != "0")
            {
                if (!System.IO.Directory.Exists(Server.MapPath("~\\img\\FindOut\\") + result + "\\productos"))
                    System.IO.Directory.CreateDirectory(Server.MapPath("~\\img\\FindOut\\") + result + "\\productos");
                if (!System.IO.Directory.Exists(Server.MapPath("~\\img\\FindOut\\") + result + "\\sucursales"))
                    System.IO.Directory.CreateDirectory(Server.MapPath("~\\img\\FindOut\\") + result + "\\sucursales");
                this.Response.Redirect("../Admin/Localizacion.aspx", false);
            }
            else
            {
                if (!System.IO.Directory.Exists(Server.MapPath("~\\img\\FindOut\\") + result))
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath("~\\img\\FindOut\\") + result);
                    
                        System.IO.Directory.CreateDirectory(Server.MapPath("~\\img\\FindOut\\") + result + "\\productos");
                        
                            System.IO.Directory.CreateDirectory(Server.MapPath("~\\img\\FindOut\\") + result + "\\sucursales");
                }
                
                
                
            }
            this.Session["idEmpresa"] = result;
            this.Response.Redirect("../Admin/Localizacion.aspx", false);

        }
        catch(Exception ex)
        {

            log.Error(ex);
            
        }

    }
}
