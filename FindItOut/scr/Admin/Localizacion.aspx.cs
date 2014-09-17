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
        else
        {
            guardaImagen();
        }
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
                muestraLogo( dt.Rows[0]["logo"].ToString() );
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
            Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
            parameters.Add("idUser", HttpContext.Current.Session["findOut"].ToString());
            string carpeta = String.Empty;

            //revisar en BD si el cliente tiene carpeta
            try
            {
                carpeta = DataAccess.executeStoreProcedureString("spr_Get_InfoLogo", parameters);
            }
            catch (Exception ex) { }

            if (!String.IsNullOrEmpty(carpeta))
            {
                //buscar el directorio
                string PathDocs = ConfigurationManager.AppSettings["EmpresasFiles"];
                string inicio = HttpContext.Current.Server.MapPath(PathDocs);
                string carpLogo = ConfigurationManager.AppSettings["CarpetaLogo"];
                carpeta = carpeta + "\\" + carpLogo;
                string directorioFisico = inicio + carpeta;

                try
                {
                    if (System.IO.Directory.Exists(directorioFisico))
                    {
                        return carpeta + "\\logo.png";
                    }
                }
                catch (Exception ex) { }
            }
            return "";
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

    public string guardaImagen()
    {
        if (Session["user"] == null)
        {
            Response.Redirect("../Start/Inicio.aspx", false);
        }
        else
        {
            if ( /*this.*/Request.Files.Count > 0)
            {
                Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
                parameters.Add("idUser", HttpContext.Current.Session["findOut"].ToString());
                string carpeta = String.Empty;
                //revisar en BD si el cliente tiene carpeta
                try
                {
                    carpeta = DataAccess.executeStoreProcedureString("spr_Get_InfoLogo", parameters);
                }
                catch (Exception ex) { }

                //ver si tiene carpeta
                if (!String.IsNullOrEmpty(carpeta))
                {
                    //buscar el directorio
                    string PathDocs = ConfigurationManager.AppSettings["EmpresasFiles"];
                    string inicio = HttpContext.Current.Server.MapPath(PathDocs);
                    string carpLogo = ConfigurationManager.AppSettings["CarpetaLogo"];
                    carpeta = carpeta + "\\" + carpLogo;
                    string directorioFisico = inicio + carpeta;
                    string directorioVirtual = "~\\EmpresasFiles\\";
                    //string extension = System.IO.Path.GetExtension(Request.Files[0].FileName);

                    try
                    {
                        if (System.IO.Directory.Exists(directorioFisico))
                        {
                            //si existe, borra el que habia
                            if (System.IO.File.Exists(directorioFisico + "\\logo.png"))
                                File.Delete(Server.MapPath(directorioVirtual) + carpeta + "\\logo.png");

                            if (System.IO.File.Exists(directorioFisico + "\\logoCh.png"))
                                File.Delete(Server.MapPath(directorioVirtual) + carpeta + "\\logoCh.png");

                            //cambiar tamaño
                            System.Drawing.Image originalImage = System.Drawing.Image.FromStream(Request.Files[0].InputStream, true, true);
                            //logo grande
                            System.Drawing.Image resizedImage = originalImage.GetThumbnailImage(160, 160, null, IntPtr.Zero);
                            //logo chico
                            System.Drawing.Image resizedImageCh = originalImage.GetThumbnailImage(50, 50, null, IntPtr.Zero);

                            //guarda el nuevo
                            //Request.Files[0].SaveAs(Server.MapPath(directorioVirtual) + carpeta + "\\logo.png" );
                            resizedImage.Save(Server.MapPath(directorioVirtual) + carpeta + "\\logo.png");
                            resizedImageCh.Save(Server.MapPath(directorioVirtual) + carpeta + "\\logoCh.png");
                        }
                    }
                    catch (Exception ex) { }
                }
            }
        }
        return "";
    }
}
