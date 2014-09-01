using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Text;
using System.IO;

public partial class search_frmSearch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    [WebMethod]
    public static string searchM(object cordenadas, string text, string distance)
    {
        return "[{\"idItem\": 1, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}" +
        ",{\"idItem\": 2, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.4466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}" +
        ",{\"idItem\": 3, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.5466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}" +
        ",{\"idItem\": 4, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.6466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}" +
        ",{\"idItem\": 5, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.7466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}" +
        ",{\"idItem\": 6, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.8466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}" +
        ",{\"idItem\": 7, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.9466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}" +
        ",{\"idItem\": 8, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.2466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}" +
        ",{\"idItem\": 9, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}" +
        ",{\"idItem\": 10, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.4466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}" +
        ",{\"idItem\": 11, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.5466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}" +
        ",{\"idItem\": 12, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.2466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}" +
        ",{\"idItem\": 13, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}" +
        ",{\"idItem\": 14, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}" +
        ",{\"idItem\": 15, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}" +
        ",{\"idItem\": 16, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}" +
        ",{\"idItem\": 17, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}" +
        ",{\"idItem\": 18, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}" +
        ",{\"idItem\": 19, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}" +
        ",{\"idItem\": 20, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}" +
        ",{\"idItem\": 21, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.6466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\"}]";

       
    }


       [WebMethod]
    public static string geTInfoItem(string idItem)
    {
        return "[{\"idItem\": 1, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\", \"description\":\"descripcion detalladata del producto exquisito de pendulos inestables\""+
           ",\"images\":\"http://192.168.1.110/finditout/img/FindOut/FindItOutName/Item/item1.jpg@@http://192.168.1.110/finditout/img/FindOut/FindItOutName/Item/item2.jpg@@http://192.168.1.110/finditout/img/FindOut/FindItOutName/Item/item3.jpg\""+
           ",\"phones\":\"32342342342@23442342324@342342\""+
           ",\"whatsaps\":\"32342342342@23442342324@342342\"" +
           ",\"twitter\":\"@qweqweqweqwe\"" +
           ",\"facebook\":\"www.facebook.com/ingesu\"}]";


    }

    
    [WebMethod]
       public static string getCompany(string idItem)
    {
        string createText = "";
        string path = System.AppDomain.CurrentDomain.BaseDirectory+@"utils\others\compania.html";

        // This text is added only once to the file. 
        if (File.Exists(path))
        {
            // Create a file to write to. 
            
            createText=File.ReadAllText(path);
        }
        return createText;


    }


    [WebMethod]
    public static string getInfoSucursal(string idItem)
    {

        string createText = "";
        string path = System.AppDomain.CurrentDomain.BaseDirectory + @"utils\others\sucursal.html";

        // This text is added only once to the file. 
        if (File.Exists(path))
        {
            // Create a file to write to.
            createText = File.ReadAllText(path);
        }
        return createText;
    }
    
    
   
}