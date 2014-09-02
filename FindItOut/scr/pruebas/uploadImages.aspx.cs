using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.IO;

public partial class pruebas_uploadImages : System.Web.UI.Page
{
 
    protected void Page_Load(object sender, EventArgs e)
    {
        String s = "";




        if (this.Request.Files.Count > 0)
        {
            File.Delete(Server.MapPath("~") + "\\img\\FindOut\\FindItOutName\\Item\\filename2.jpg");

            this.Request.Files[0].SaveAs(Server.MapPath("~")+"\\img\\FindOut\\FindItOutName\\Item\\filename2.jpg");
        }
        this.respuesta.InnerHtml = "respuasdasesta";
     
    }

  
}