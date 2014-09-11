using System;
using System.Collections.Generic;
using System.Configuration;
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
        if (Session["user"] == null)
        {
            Response.Redirect("../Start/Inicio.aspx", false);
        }
        hdnUser.Value = HttpContext.Current.Session["findOut"].ToString();
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
            if(Request.Files.Count > 0)
            {
                var file = Request.Files[0];


                Dictionary< string, object > parameters = new System.Collections.Generic.Dictionary< string, object >();
                //parameters.Add("idUser", HttpContext.Current.Session["findOut"].ToString());
                string carpeta = "company";
                //revisar en BD si el cliente tiene carpeta

                //carpeta = DataAccess.executeStoreProcedureString("spr_Get_InfoLogo", parameters);

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
                        if (System.IO.File.Exists(directorioFisico + "\\" + filename))
                            File.Delete(directorioFisico + "\\" + filename);

                        if (System.IO.File.Exists(directorioFisico + "\\small_" + filename))
                            File.Delete(directorioFisico + "\\small_" + filename);

                        //cambiar tamaño
                        System.Drawing.Image originalImage =
                                    System.Drawing.Image.FromStream( file.InputStream, true, true );
                        //logo grande
                        System.Drawing.Image resizedImage = originalImage.GetThumbnailImage( 160, 160, null, IntPtr.Zero );
                        //logo chico
                        System.Drawing.Image resizedImageCh = originalImage.GetThumbnailImage( 50, 50, null, IntPtr.Zero );

                        //guarda el nuevo
                        //Request.Files[0].SaveAs(Server.MapPath(directorioVirtual) + carpeta + "\\logo.png" );
                        resizedImage.Save(directorioFisico + "\\" + filename);
                        resizedImageCh.Save(directorioFisico + "\\small_" + filename);
                    }

                }
            ret = "{\"success\": true, \"message\": \"\", \"attr\": {\"idProductImage\": " + 56 + " , \"name\": \"" + filename + "\"}}";
        }
        catch (Exception ex) {
            ret = "{\"success\": false, \"message\": \"" + ex.Message + "\"}";
        }        

        return ret;
    }

    [WebMethod]
    public static Category[] getCategories(int idUser)
    {
        List<Product> products1 = new List<Product>();
        products1.Add(new Product { active = true, idProduct = 1, productName = "Producto test 1", ProductImages = new List<ProductImage> { new ProductImage { idProductImage = 1, name = "image.png" }, new ProductImage { idProductImage = 2, name = "image2.png" } } });
        products1.Add(new Product { active = true, idProduct = 2, productName = "Producto test 2" });
        List<Product> products2 = new List<Product>();
        products2.Add(new Product { active = true, idProduct = 11, productName = "Producto test 11", ProductImages = new List<ProductImage>() });
        products2.Add(new Product { active = true, idProduct = 12, productName = "Producto test 12", ProductImages = new List<ProductImage>() });
        products2.Add(new Product { active = true, idProduct = 13, productName = "Producto test 13", ProductImages = new List<ProductImage>() });
        products2.Add(new Product { active = true, idProduct = 14, productName = "Producto test 14", ProductImages = new List<ProductImage>() });
        Category cat1 = new Category { active = true, categoryName = "Cat1", idCategory = 1, Products = products1};
        Category cat2 = new Category { active = true, categoryName = "Cat2", idCategory = 2, Products = products2};
        return new[]{cat1, cat2};
    }

    [WebMethod]
    public static int saveCategory(Category category)
    {
        return 25;
    }

    [WebMethod]
    public static bool deleteCategory(int idCategory)
    {
        return true;
    }

    [WebMethod]
    public static int saveProduct(Product product)
    {
        return 25;
    }

    [WebMethod]
    public static bool deleteProduct(int idProduct)
    {
        return true;
    }
}