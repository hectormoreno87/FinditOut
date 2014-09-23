using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Catalog : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user"] == null || HttpContext.Current.Session["findOut"] == null)
        {
            Response.Redirect("../Start/Inicio.aspx", false);
        }
        hdnUser.Value = HttpContext.Current.Session["findOut"].ToString();
        if (!IsPostBack)
        {
            Dictionary< string, object > parameters = new System.Collections.Generic.Dictionary< string, object >();
            parameters.Add( "idUser", HttpContext.Current.Session["findOut"].ToString() );
            string carpeta = string.Empty;
            carpeta = DataAccess.executeStoreProcedureString( "spr_Get_InfoLogo", parameters );
            ViewState["carpeta"] = carpeta;
            hdnCo.Value = carpeta;
        }
        if (Request.RequestType == "POST")
        {
            string json = string.Empty;
            json = saveImage();
            Response.Clear();
            Response.ContentType = "application/json";
            Response.Write(json);
            Response.End();
        }
    }

    private string saveImage()
    {
        string ret = string.Empty;
        string filename = string.Empty;
        try
        {
            if ( Request.Files.Count > 0 )
            {
                var file = Request.Files[0];


                Dictionary< string, object > parameters = new System.Collections.Generic.Dictionary< string, object >();
                parameters.Add( "idUser", HttpContext.Current.Session["findOut"].ToString() );
                string carpeta = string.Empty;
                //revisar en BD si el cliente tiene carpeta

                carpeta = DataAccess.executeStoreProcedureString( "spr_Get_InfoLogo", parameters );

                //ver si tiene carpeta
                if ( !String.IsNullOrEmpty( carpeta ) )
                {
                    //buscar el directorio
                    string PathDocs = ConfigurationManager.AppSettings["EmpresasFiles"];
                    string inicio = HttpContext.Current.Server.MapPath( PathDocs );
                    string directorioFisico = inicio + carpeta + "\\products\\" + Request.Form["idProduct"];
                    //string directorioVirtual = ConfigurationManager.AppSettings["EmpresasFiles"];
                    //string extension = System.IO.Path.GetExtension(Request.Files[0].FileName);

                    filename = file.FileName;

                    Common.makeDirectoryIfNotExists( directorioFisico );
                    //si existe, borra el que habia
                    if ( System.IO.File.Exists( directorioFisico + "\\" + filename ) )
                        File.Delete( directorioFisico + "\\" + filename );

                    if ( System.IO.File.Exists( directorioFisico + "\\small_" + filename ) )
                        File.Delete( directorioFisico + "\\small_" + filename );

                    //cambiar tamaño
                    System.Drawing.Image originalImage =
                                System.Drawing.Image.FromStream( file.InputStream, true, true );
                    //logo grande
                    System.Drawing.Image resizedImage = originalImage.GetThumbnailImage( 160, 160, null, IntPtr.Zero );
                    //logo chico
                    System.Drawing.Image resizedImageCh = originalImage.GetThumbnailImage( 50, 50, null, IntPtr.Zero );

                    //guarda el nuevo
                    //Request.Files[0].SaveAs(Server.MapPath(directorioVirtual) + carpeta + "\\logo.png" );
                    resizedImage.Save( directorioFisico + "\\" + filename );
                    resizedImageCh.Save( directorioFisico + "\\small_" + filename );

                    parameters.Clear();
                    parameters.Add( "idUser", HttpContext.Current.Session["findOut"].ToString() );
                    parameters.Add( "idProducto", Request.Form["idProduct"] );
                    parameters.Add( "idImagen", Request.Form["idImage"] );
                    parameters.Add( "nombreArchivo", filename );
                    int result = 0;
                    try
                    {
                        result = DataAccess.executeStoreProcedureGetInt( "Spr_insert_image", parameters );
                    }
                    catch ( Exception ex )
                    {

                    }
                    if (result > 0)
                    {
                        ret = "{\"success\": true, \"message\": \"\", \"attr\": {\"idImage\": " + result + " , \"fileName\": \"" +
                  filename + "\"}}";
                    }
                    else
                    {
                        ret = "{\"success\": false, \"message\": \"Error al guardar los datos\"}";
                    }
                }

            }
            /*ret = "{\"success\": true, \"message\": \"\", \"attr\": {\"idProductImage\": " + 56 + " , \"name\": \"" +
                  filename + "\"}}";*/
        }
        catch ( Exception ex )
        {
            ret = "{\"success\": false, \"message\": \"" + ex.Message + "\"}";
        }

        return ret;
    }

    [WebMethod]
    public static Category[] getCategories(int idUser)
    {
        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
        parameters.Add("idUser", idUser);
        
        DataSet dsResult;
        List<Category> categories = new List< Category >();
        try
        {
            dsResult = DataAccess.executeStoreProcedureDataSet("spr_GET_Categorias", parameters);
            categories = (from ca in dsResult.Tables[0].AsEnumerable()
                          select new Category()
                          {
                              idCategory = Convert.ToInt32(ca["idCategory"]),
                              active = Convert.ToBoolean(ca["active"]),
                              categoryName = Convert.ToString(ca["categoryName"])
                          }).ToList();

            foreach ( var category in categories )
            {
                var products = (from pr in dsResult.Tables[1].AsEnumerable()
                                where Convert.ToInt32(pr["idCategory"]) == category.idCategory
                                select new Product()
                                {
                                    idProduct = Convert.ToInt32(pr["idProduct"]),
                                    idCategory = Convert.ToInt32(pr["idCategory"]),
                                    active = Convert.ToBoolean(pr["active"]),
                                    productName = Convert.ToString(pr["productName"])
                                }).ToList();
                category.Products = products;

                foreach ( var product in products )
                {
                    var images = (from img in dsResult.Tables[2].AsEnumerable()
                                  where Convert.ToInt32(img["idProduct"]) == product.idProduct
                                  select new ProductImage() {
                                      idImage = Convert.ToInt32(img["idImage"]),
                                      idProduct = Convert.ToInt32(img["idProduct"]),
                                      fileName = Convert.ToString(img["fileName"])
                                  }).ToList();
                    product.ProductImages = images;
                }
            }

        }
        catch (Exception ex) { 
        
        }

        return categories.ToArray();
    }

    [WebMethod]
    public static int saveCategory(int idUser, Category category)
    {
        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
        parameters.Add("idUser", idUser);
        parameters.Add( "idCategoria", category.idCategory );
        parameters.Add("activo", category.active);
        parameters.Add("categoriaNombre", category.categoryName);
        int result = 0;
        try
        {
            result = DataAccess.executeStoreProcedureGetInt("Spr_insert_categoria", parameters);
            
        }
        catch (Exception ex)
        {

        }
        return result;
    }

    [WebMethod]
    public static bool deleteCategory(int idCategory)
    {
        return true;
    }

    [WebMethod]
    public static int saveProduct(int idUser, int idCategory, Product product)
    {
        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
        parameters.Add("idUser", idUser);
        parameters.Add("idCategoria", idCategory);
        parameters.Add("idProducto", product.idProduct);
        parameters.Add("activo", product.active);
        parameters.Add("productoNombre", product.productName);
        int result = 0;
        try
        {
            result = DataAccess.executeStoreProcedureGetInt("Spr_insert_producto", parameters);
        }
        catch (Exception ex)
        {

        }
        return result;
    }

    [WebMethod]
    public static bool deleteProduct(int idProduct)
    {
        return true;
    }

    [WebMethod]
    public static string deleteImage(int idUser, int idProduct, int idImage)
    {
        string errorMessage = string.Empty; 
        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
        parameters.Add("idUser", idUser);
        string carpeta = string.Empty;
        //revisar en BD si el cliente tiene carpeta

        carpeta = DataAccess.executeStoreProcedureString("spr_Get_InfoLogo", parameters);
        if (!String.IsNullOrEmpty(carpeta))
        {
            string PathDocs = ConfigurationManager.AppSettings["EmpresasFiles"];
            string inicio = HttpContext.Current.Server.MapPath(PathDocs);
            string directorioFisico = inicio + carpeta + "\\products\\" + idProduct;

            parameters.Clear();
            parameters.Add("idUser", idUser);
            parameters.Add("idProducto", idProduct);
            parameters.Add("idImagen", idImage);
            string result = string.Empty;
            try
            {
                result = DataAccess.executeStoreProcedureString("Spr_delete_image", parameters);
            }
            catch (Exception ex)
            {
                errorMessage = ex.Message;
            }

            string filename = result;

            Common.makeDirectoryIfNotExists(directorioFisico);
            //si existe, borra el que habia
            if (System.IO.File.Exists(directorioFisico + "\\" + filename))
                File.Delete(directorioFisico + "\\" + filename);

            if (System.IO.File.Exists(directorioFisico + "\\small_" + filename))
                File.Delete(directorioFisico + "\\small_" + filename);
        }

        return "{ \"success\": " + (string.IsNullOrEmpty(errorMessage) ? "true" : "false") + ", \"idImage\": " + idImage + " , \"message\": \"" + errorMessage + " \" }";
    }
}