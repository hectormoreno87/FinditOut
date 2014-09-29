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
        else
        {
            guardaImagen();
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
                //dentro de la carpeta "Sucursales", creal otra con el nombre de la sucursal
                resp = Common.creaCarpetaSucursales(carpSuc, inicio + carpeta + "\\", suc.Trim());
                if (String.IsNullOrEmpty(resp))//todo bien
                {
                    string dirSuc = inicio + carpeta + "\\" + carpSuc + "\\";
                    //buscar si esta la carpeta Temp con imagenes
                    if (System.IO.Directory.Exists(dirSuc + "Temp"))
                    {
                        try
                        {
                            DirectoryInfo source = new DirectoryInfo(dirSuc + "Temp");
                            DirectoryInfo target = new DirectoryInfo(dirSuc + suc.Trim());
                            //copiar las imagenes a la carpeta que le corresponde
                            foreach (FileInfo fi in source.GetFiles())
                            {
                                fi.CopyTo(Path.Combine(target.ToString(), fi.Name), true);
                            }
                        }
                        catch (Exception ex2)
                        {
                        }

                        //borrar la carpeta temp
                        try
                        {
                            Directory.Delete(dirSuc + "Temp", true);
                        }
                        catch (Exception ex3)
                        {
                        }
                    }
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
            }
            else
            {
                result = 0;
            }
        }
        return result;
    }

    [WebMethod]
    public static string sacaImagen(string suc)
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
                string carpLogo = ConfigurationManager.AppSettings["CarpetaSucursales"];
                carpeta = carpeta + "\\" + carpLogo;
                string directorioFisico = inicio + carpeta;
                try
                {
                    //ver si existe la carpeta Temp
                    if (System.IO.Directory.Exists(directorioFisico + "\\" + "Temp"))
                    {
                        carpeta = carpeta + "\\" + "Temp";
                        return carpeta + "\\1.png";
                    }
                    else
                    {
                        //aqui necesito el nombre de la empresa
                        if (!String.IsNullOrEmpty(suc))
                        {
                            if (System.IO.Directory.Exists(directorioFisico + "\\" + suc))
                            {
                                carpeta = carpeta + "\\" + "Temp";
                                return carpeta + "\\1.png";
                            }
                        }
                    }


                }
                catch (Exception ex) { }
            }
            return "";
        }
    }

    public string tieneEmpresa(string idUser)
    {
        string carpeta = null;
        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
        parameters.Add("idUser", idUser);

        try
        {
            carpeta = DataAccess.executeStoreProcedureString("spr_Get_InfoLogo", parameters);
        }
        catch (Exception ex) { }
        return carpeta;
    }

    public bool creaDirectorio(string carpetaEmpresa, string carpeta)
    {
        bool respuesta;
        //buscar el directorio
        string PathDocs = ConfigurationManager.AppSettings["EmpresasFiles"];
        string inicio = HttpContext.Current.Server.MapPath(PathDocs);
        string directorioFisico = inicio + carpetaEmpresa + "\\" + carpeta;

        try
        {
            if (!System.IO.Directory.Exists(directorioFisico))
            {
                System.IO.Directory.CreateDirectory(directorioFisico);
            }

            if (System.IO.Directory.Exists(directorioFisico))
                respuesta = true;
            else
                respuesta = false;
        }
        catch (Exception ex)
        {
            respuesta = false;
        }

        return respuesta;
    }

    public int cuentaImagenesDirectorio(string carpetaEmpresa, string carpeta, int limite)
    {
        //buscar el directorio
        string PathDocs = ConfigurationManager.AppSettings["EmpresasFiles"];
        string inicio = HttpContext.Current.Server.MapPath(PathDocs);
        string directorioFisico = inicio + carpetaEmpresa + "\\" + carpeta;

        //contar cuantas imagenes estan en la carpeta
        try
        {
            string[] dirs = Directory.GetFiles(directorioFisico, "*.*");
            int cantidad = dirs.Length;

            if (cantidad < limite)
            {
                return cantidad;
            }
            else
                return -1;
        }
        catch (Exception ex)
        {
            return -1;
        }

    }

    public string guardaImagen()
    {
        if (Session["user"] == null)
        {
            Response.Redirect("../Start/Inicio.aspx", false);
        }
        else
        {
            int nueva = 0;

            if ( /*this.*/Request.Files.Count > 0)
            {
                //Revisar que no este vacio el nombre del archivo:
                if (String.IsNullOrEmpty(Request.Files[0].FileName.ToString()))
                {
                    return String.Empty;
                }
                else
                {
                    if (nueva == 0)
                    {
                        string carpeta = tieneEmpresa(HttpContext.Current.Session["findOut"].ToString());
                        if (!String.IsNullOrEmpty(carpeta)) //tiene carpeta la empresa
                        {
                            carpeta = carpeta + "\\" + ConfigurationManager.AppSettings["CarpetaSucursales"];
                            if (creaDirectorio(carpeta, "Temp"))
                            {
                                int limite = 5;
                                int imgs = cuentaImagenesDirectorio(carpeta, "Temp", limite);
                                if (imgs > -1)
                                {
                                    carpeta = carpeta + "\\" + "Temp";
                                    string directorioVirtual = "~\\EmpresasFiles\\" + carpeta;
                                    try
                                    {
                                        //cambiar tamaño grande
                                        System.Drawing.Image originalImage = System.Drawing.Image.FromStream(Request.Files[0].InputStream, true, true);
                                        System.Drawing.Image resizedImage = originalImage.GetThumbnailImage(160, 160, null, IntPtr.Zero);
                                        //guarda 
                                        resizedImage.Save(Server.MapPath(directorioVirtual) + "\\" + (++imgs) + ".png");

                                    }
                                    catch (Exception ex) { }
                                }
                                else
                                {
                                    //no puede guardar más imagenes
                                    ClientScript.RegisterStartupScript(GetType(), "error","mensajeServidor(0, "+ Resources.GlobalResource.lbl_NoMasImgs +");", true);
                                }
                            }
                            else
                            {
                                //no se creo directorio
                            }
                        }//if: tiene carpeta la empresa
                    }// if: es nueva
                }//else: tienen nombre archivo que guardar
            }// if: el Response trae algo   
        }
        return String.Empty;
    }

}