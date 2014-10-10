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
using log4net;
using System.Text;
using System.Web.Script.Serialization;

public partial class Admin_Sucursales : System.Web.UI.Page
{
    private static readonly ILog log = LogManager.GetLogger(typeof(Admin_Sucursales));
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user"] == null || Session["idEmpresa"] == null)
        {
            Response.Redirect("../Start/Inicio.aspx", false);
        }
        else
        {
            if (!IsPostBack)
            {
                this.typeofload.Value = Request.QueryString["type"]!=null?Request.QueryString["type"].ToString():"";
                // Limpiar();
                //cargaRedesSociales();
                if (Request.QueryString.Count > 0)
                {
                    //this.Session["idSucursal"] = Request.QueryString["id"];
                    loadInfo(Request.QueryString["id"]);

                    string empresa = this.Session["idEmpresa"].ToString();
                    string sucursal = Request.QueryString["id"];
                    string directorio = "~\\img\\findOut\\" + empresa + "\\sucursales\\" + sucursal + "\\";
                    if (!System.IO.Directory.Exists(Server.MapPath(directorio)))
                    {
                        System.IO.Directory.CreateDirectory(Server.MapPath(directorio));

                    }



                }
                else
                {
                    this.idSuc.Value = "";
                }

            }
            else
            {
                this.Session["newSucursal"] = 1;
                if (Request.RequestType == "POST" && isImage())
                {
                    Response.Clear();
                    Response.ContentType = "application/json";
                    ResponseClass r = new ResponseClass();

                    if (guardaImagen())
                    {
                        //this.resultImage.Value = "<img src=\"../img/FindOut/"+this.Session["idEmpresa"].ToString()+"/logo.png\">";
                        r.Result = "1";

                        Dictionary<string, object> p = new Dictionary<string, object>();
                        p.Add("@idSucursal", Request.QueryString["id"]);
                        DataTable dt = DataAccess.executeStoreProcedureDataTable("spr_GET_imagesSucursal", p);
                        foreach (DataRow dr in dt.Rows)
                        {

                            r.Data += getImageSucursal(dr, Request.QueryString["id"]);
                        }


                        //r.Data = "<img src='../img/FindOut/" + this.Session["idEmpresa"].ToString() + "/logo.png?d=" + ((int)DateTime.Now.Second) + "'>";
                        var json = new JavaScriptSerializer().Serialize(r);
                        //  JSON.Parse("{number:1000, str:'string', array: [1,2,3,4,5,6]}");
                        //Response.Write("{\"success\": false, \"message\": \"Error al guardar los datos\"}");
                        Response.Write(json);

                    }
                    else
                    {
                        r.Result = "0";
                        r.Data = "";
                        var json = new JavaScriptSerializer().Serialize(r);
                        Response.Write(json);
                    }


                    Response.End();
                }
            }
        }
    }


    [WebMethod]
    public static string deleteImage(int idImage, string idSucursal)
    {
        try
        {
            string empresa = HttpContext.Current.Session["idEmpresa"].ToString();
            string sucursal = idSucursal;
            // This text is added only once to the file. 
            if (File.Exists(HttpContext.Current.Server.MapPath("~\\img\\findOut\\" + empresa + "\\sucursales\\" + sucursal + "\\" + idImage + ".png")))
            {
                File.Delete(HttpContext.Current.Server.MapPath("~\\img\\findOut\\" + empresa + "\\sucursales\\" + sucursal + "\\" + idImage + ".png"));
                Dictionary<string, object> p = new Dictionary<string,object>();
                p.Add("@idImage", idImage);
                p.Add("@idSucursal", idSucursal);
                DataAccess.executeStoreProcedureNonQuery("spr_DETELTE_ImageSucursal",p);


            }
            return "1";


        }catch(Exception ex)
        {
            log.Error(ex);
        }

        return "0";
    }

    public static string getImageSucursal(DataRow dr, string idSucursal)
    {
        string createText = "";
        string path = System.AppDomain.CurrentDomain.BaseDirectory + @"utils\others\imageSucursal.htm";
        string empresa = HttpContext.Current.Session["idEmpresa"].ToString();
        string sucursal = idSucursal;
        // This text is added only once to the file. 
        if (File.Exists(path))
        {
            // Create a file to write to.
            createText = File.ReadAllText(path);
            createText= createText.Replace("imagen@","..\\img\\findOut\\" + empresa + "\\sucursales\\" + sucursal + "\\"+dr["image"]+".png?d="+2);
            createText = createText.Replace("@id@", dr["image"].ToString());
        }
        return createText;
    }


    public bool isImage()
    {
        bool b = false;


                if (this.Request.Form["image"].ToString() == "0" || this.Request.Form["image"].ToString() == "")
                {
                    return false;
                }
                else{
                    return true;
                }

                
            
        

    }

    [WebMethod]
    public static string getPhones(string idSucursal)
    {

        String sResult = "";
        int i = 0;
        try
        {
            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@idSucursal", idSucursal);
            p.Add("@idUser", HttpContext.Current.Session["findOut"].ToString());
            DataTable dt = DataAccess.executeStoreProcedureDataTable("spr_GET_SucursalePhones", p);
            if (dt.Rows.Count == 0)
            {


                sResult += System.IO.File.ReadAllText(HttpContext.Current.Server.MapPath("../utils/others/phones.htm"));
                sResult = sResult.Replace("@lbl_telSucExpli", Resources.GlobalResource.lbl_telSucExpli);
                sResult = sResult.Replace("@lbl_telSucExpliMas", Resources.GlobalResource.lbl_telSucExpliMas);
                sResult = sResult.Replace("@lbl_UsarWhatsApp", Resources.GlobalResource.lbl_UsarWhatsApp);
                sResult = sResult.Replace("@", i + "");
                i++;

            }
            else
            {




                foreach (DataRow dr in dt.Rows)
                {
                    if (i == 0)
                    {
                        string sResultTemporal = System.IO.File.ReadAllText(HttpContext.Current.Server.MapPath("../utils/others/phones.htm"));
                        sResult += sResultTemporal.Replace("value=''", "value='" + dr["vTelefono"].ToString() + "'");


                    }
                    else
                    {
                        string sResultTemporal = System.IO.File.ReadAllText(HttpContext.Current.Server.MapPath("../utils/others/phonesDel.htm"));
                        sResultTemporal = sResultTemporal.Replace("value=''", "value='" + dr["vTelefono"].ToString() + "'");

                        if (dr["bWhatsApp"].ToString() == "True")
                        {
                            sResultTemporal = sResultTemporal.Replace("type='checkbox'", "type='checkbox' checked ");
                        }
                        sResult += sResultTemporal;
                    }
                    sResult = sResult.Replace("@lbl_telSucExpli", Resources.GlobalResource.lbl_telSucExpli);
                    sResult = sResult.Replace("@lbl_telSucExpliMas", Resources.GlobalResource.lbl_telSucExpliMas);
                    sResult = sResult.Replace("@lbl_UsarWhatsApp", Resources.GlobalResource.lbl_UsarWhatsApp);
                    sResult = sResult.Replace("@", i + "");
                    i++;
                }



            }

        }
        catch (Exception ex)
        {

        }
        sResult = sResult.Replace("\"", "'");
        sResult = sResult.Replace("\n", "");
        sResult = sResult.Replace("\r", "");
        string json = "[{\"data\":\"" + sResult + "\",\"count\":" + i + "}]";
        return json;

    }

    [WebMethod]
    public static string cargaImagenes(string id)
    {
        StringBuilder sb = new StringBuilder();

        try
        {

            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@idSucursal", id);
            DataTable dt = DataAccess.executeStoreProcedureDataTable("spr_GET_imagesSucursal", p);
            foreach (DataRow dr in dt.Rows)
            {

               sb.Append(getImageSucursal(dr,id));
            }

        }
        catch (Exception ex)
        {
            log.Error(ex);
        }

        return sb.ToString();



    }


    public void loadInfo(string idSucursal)
    {

        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
        DataSet dt = null;
        try
        {
            this.idSuc.Value = idSucursal;
            parameters.Add("@idSucursal", idSucursal);
            parameters.Add("@idUser", Session["findOut"]);
            dt = DataAccess.executeStoreProcedureDataSet("spr_GET_SucursalesByID", parameters);

            DataTable dtSucursal = dt.Tables[0];

            if (dtSucursal.Rows.Count > 0)
            {
                DataRow dr = dtSucursal.Rows[0];
                this.ltTiTulo.Text = dr["vNombreSuc"].ToString();
                this.txtNomSuc.Text = dr["vNombreSuc"].ToString();
                this.txtDom.Text = dr["vDirecc"].ToString();
                this.lblLongitud.Text = dr["vLongitud"].ToString();
                this.lblLatitud.Text = dr["vLatitud"].ToString();
                this.placeNameHidden.Value = dr["placeName"].ToString();

            }


        }
        catch (Exception ex)
        {

log.Error(ex);
        }
    }
    public void Limpiar()
    {
        txtNomSuc.Text = txtDom.Text = txtDom.Text = String.Empty;
    }

    //public void cargaRedesSociales()
    //{
    //    div_redesS.Controls.Clear();
    //    Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
    //    DataTable dt = null;
    //    try
    //    {
    //        dt = DataAccess.executeStoreProcedureDataTable("spr_GET_RedesSociales", parameters);
    //    }
    //    catch (Exception ex) { 


    //    }
    //    if (dt != null && dt.Rows.Count > 0)
    //    {
    //        string cad = "<table>";
    //        for (int i = 0; i < dt.Rows.Count; i++)
    //        {
    //            cad += "<tr>";
    //            //logo
    //            cad += "<td style=\"width:65px;\">";
    //            cad += "<img src=\"" + dt.Rows[i]["logoRedS"].ToString() + "\" height=\"25\" width=\"25\">";
    //            cad += "</td>";
    //            cad += "<td>";
    //            cad += "<input name= \"red_" + dt.Rows[i]["idRedS"].ToString() + "\" class=\"cajaLarga\">";
    //            cad += "</td>";

    //            cad += "</tr>";
    //        }
    //        cad += "</table>";

    //        LiteralControl menu = new LiteralControl(cad);
    //        div_redesS.Controls.Add(menu);
    //    }
    //}

    [WebMethod]
    public static string cargaRedesSocialesWM(string idSucursal)
    {
        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
        parameters.Add("@idSucursal", idSucursal);
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
                cad += "<input name= \"red_" + dt.Rows[i]["idRedS"].ToString() + "\" value='" + dt.Rows[i]["vRedSocial"].ToString() + "' class=\"cajaLarga masterTooltip\" title=\"" + dt.Rows[i]["nombreRedS"].ToString() + "\">";
                cad += "</td>";

                cad += "</tr>";
                cad += "<tr>";
                //logo
                cad += "<td style=\"width:65px;\">";
                
                cad += "</td>";
                cad += "<td>";
                cad += "<span id= \"error_" + dt.Rows[i]["idRedS"].ToString() + "\" ></span>";
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

  

    //public string tieneEmpresa(string idUser)
    //{
    //    string carpeta = null;
    //    Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
    //    parameters.Add("idUser", idUser);

    //    try
    //    {
    //        carpeta = DataAccess.executeStoreProcedureString("spr_Get_InfoLogo", parameters);
    //    }
    //    catch (Exception ex) { }
    //    return carpeta;
    //}

   

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
                else
                {
                    
                        string empresa = this.Session["idEmpresa"].ToString();
                        string sucursal = Request.QueryString["id"];
                        if (!String.IsNullOrEmpty(empresa) && !String.IsNullOrEmpty(sucursal)) //tiene carpeta la empresa
                        {

                            string directorio = "~\\img\\findOut\\" + empresa+"\\sucursales\\"+sucursal+"\\";

                            Dictionary<string, object> p= new Dictionary<string,object>();
                            p.Add("@idSucursal",sucursal);
                            int imgs = DataAccess.executeStoreProcedureGetInt("spr_GET_NumOfImagesFromSucursal", p) + 1; ;

       
                            try
                            {
                                //cambiar tamaño grande
                                System.Drawing.Image originalImage = System.Drawing.Image.FromStream(Request.Files[0].InputStream, true, true);
                                System.Drawing.Image resizedImage = originalImage.GetThumbnailImage(300, 300, null, IntPtr.Zero);
                                //guarda 
                                if (!System.IO.File.Exists(Server.MapPath(directorio+imgs+".png")))
                                {
                                    resizedImage.Save(Server.MapPath(directorio) +  (imgs) + ".png");
                                    Dictionary<string, object> p2 = new Dictionary<string, object>();
                                    p2.Add("@idSucursal", sucursal);
                                    p2.Add("@imagen", imgs+"");
                                    p2.Add("@estatus", 1);
                                    DataAccess.executeStoreProcedureNonQuery("spr_INSERT_ImagenSucursal", p2);
                                    return true;
                                }
                                else

                                {
                                    return false;
                                }
                                

                                

                            }
                            catch (Exception ex)
                            {
                                log.Error(ex);
                            }

                        }
                }//else: tienen nombre archivo que guardar
            }// if: el Response trae algo   
        }
        return false;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {




            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@idUser", this.Session["findOut"].ToString());
            p.Add("@vNombreSuc", this.txtNomSuc.Text);
            p.Add("@vDirecc", this.txtDom.Text);
            p.Add("@vPlaceName", this.Request.Form["searchTextField"]);
            p.Add("@vLongitud", this.Request.Form["inputLongitud"]);
            p.Add("@vLatitud", this.Request.Form["inputLatitud"]);


            DataTable dt = getTablePhones();
            DataTable dtRedes = getTableRedes();

            foreach (string s in this.Request.Form.AllKeys)
            {
                if (s.Contains("idtel"))
                {
                    DataRow dr = dt.NewRow();
                    dr["idSucursal"] = 0;//se modificará en la consulta
                    dr["vTelefono"] = this.Request.Form[s].ToString();
                    if (this.Request.Form["CheckBox_" + s.Split('_')[1]] != null)
                    {
                        dr["bWhatsApp"] = 1;
                    }
                    else
                    {
                        dr["bWhatsApp"] = 0;
                    }
                    dt.Rows.Add(dr);

                }

                if (s.Contains("red"))
                {
                    DataRow drR = dtRedes.NewRow();
                    drR["idSucursal"] = 0;//se modificará en la consulta
                    drR["vRedSocial"] = this.Request.Form[s].ToString();
                    drR["idRedSocial"] = int.Parse(s.Split('_')[1]);
                    dtRedes.Rows.Add(drR);

                }



            }
            p.Add("@phones", dt);
            p.Add("@redes", dtRedes);
            if (this.idSuc.Value == "")
            {
                int idS = DataAccess.executeStoreProcedureGetInt("spr_INSERT_Sucursal_", p);


                string empresa = this.Session["idEmpresa"].ToString();
                string sucursal = idS+"";
                string directorio = "~\\img\\findOut\\" + empresa + "\\sucursales\\" + sucursal + "\\";
                if (!System.IO.Directory.Exists(Server.MapPath(directorio)))
                {
                        System.IO.Directory.CreateDirectory(Server.MapPath(directorio));
                    
                }
                
                                

                Response.Redirect("../Admin/Sucursales.aspx?id=" + idS+"&&type=1", false);
            }
            else
            {
                p.Add("@idSucursal", this.idSuc.Value);
                int idS = DataAccess.executeStoreProcedureGetInt("spr_UPDATE_Sucursal_", p);
                string empresa = this.Session["idEmpresa"].ToString();
                string sucursal = idS + "";
                string directorio = "~\\img\\findOut\\" + empresa + "\\sucursales\\" + sucursal + "\\";
                if (!System.IO.Directory.Exists(Server.MapPath(directorio)))
                {
                        System.IO.Directory.CreateDirectory(Server.MapPath(directorio));
                    
                }

                //this.Session["newSucursal"] = 1;
                Response.Redirect("../Admin/Sucursales.aspx?id=" + idS + "&&type=1", false);

            }


        }
        catch (Exception ex)
        {
            log.Error(ex);
        }

    }

    public DataTable getTablePhones()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("idSucursal", typeof(int));
        dt.Columns.Add("vTelefono", typeof(string));
        dt.Columns.Add("bWhatsApp", typeof(Boolean));
        return dt;

    }

    public DataTable getTableRedes()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("idSucursal", typeof(int));
        dt.Columns.Add("vRedSocial", typeof(string));
        dt.Columns.Add("idRedSocial", typeof(int));
        return dt;

    }
    protected void btnEliminiar_Click(object sender, EventArgs e)
    {
       
    }



    [WebMethod]
    public static void Delete_Sucursal(string idSuc)
    {
        try
        {

            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@idSucursal", idSuc);
            DataAccess.executeStoreProcedureNonQuery("spr_DELETE_Sucursal_", p);

            string empresa = HttpContext.Current.Session["idEmpresa"].ToString();
            string sucursal = idSuc;
            string directorio = "~\\img\\findOut\\" + empresa + "\\sucursales\\" + sucursal;

            if (System.IO.Directory.Exists(HttpContext.Current.Server.MapPath(directorio)))
            {
                System.IO.Directory.Delete(HttpContext.Current.Server.MapPath(directorio), true);

            }
             HttpContext.Current.Response.Redirect("~/Admin/Sucursales.aspx",false);

        }
        catch (Exception ex)
        {
            log.Error(ex);
            
        }
    }



    protected void eliminar_Click(object sender, EventArgs e)
    {
        try
        {

            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@idSucursal", this.idSuc.Value);
            DataAccess.executeStoreProcedureNonQuery("spr_DELETE_Sucursal_", p);

            string empresa = this.Session["idEmpresa"].ToString();
            string sucursal = Request.QueryString["id"];
            string directorio = "~\\img\\findOut\\" + empresa + "\\sucursales\\" + sucursal;

            if (System.IO.Directory.Exists(Server.MapPath(directorio)))
            {
                //System.IO.Directory.Delete(Server.MapPath(directorio), true);

            }
            Response.AddHeader("REQUIRES_AUTH", "1");
            Response.Redirect("../Admin/Sucursales.aspx?" + "type=0", false);

        }
        catch (Exception ex)
        {
            log.Error(ex);
        }
    }
}