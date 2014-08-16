using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for wsFindItOut
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class wsFindItOut : System.Web.Services.WebService {

    public wsFindItOut () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }

    [WebMethod]
    public string GetInfo(string search, string latitud, string longitude, string distance)
    {
        return "[{\"idItem\": 1, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.3466798\", \"logo\":\"logo1\"}" +
         ",{\"idItem\": 2, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.4466798\", \"logo\":\"logo1\"}" +
         ",{\"idItem\": 1, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.5466798\", \"logo\":\"logo1\"}" +
         ",{\"idItem\": 2, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.6466798\", \"logo\":\"logo1\"}" +
         ",{\"idItem\": 1, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.7466798\", \"logo\":\"logo1\"}" +
         ",{\"idItem\": 2, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.8466798\", \"logo\":\"logo1\"}" +
         ",{\"idItem\": 1, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.9466798\", \"logo\":\"logo1\"}" +
         ",{\"idItem\": 2, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.2466798\", \"logo\":\"logo1\"}" +
         ",{\"idItem\": 1, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"logo1\"}" +
         ",{\"idItem\": 2, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.4466798\", \"logo\":\"logo1\"}" +
         ",{\"idItem\": 1, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.5466798\", \"logo\":\"logo1\"}" +
         ",{\"idItem\": 2, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.2466798\", \"logo\":\"logo1\"}" +
         ",{\"idItem\": 1, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"logo1\"}" +
         ",{\"idItem\": 1, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"logo1\"}" +
         ",{\"idItem\": 1, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"logo1\"}" +
         ",{\"idItem\": 1, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"logo1\"}" +
         ",{\"idItem\": 1, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"logo1\"}" +
         ",{\"idItem\": 1, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"logo1\"}" +
         ",{\"idItem\": 1, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"logo1\"}" +
         ",{\"idItem\": 1, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"logo1\"}" +
         ",{\"idItem\": 2, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.6466798\", \"logo\":\"logo1\"}]";
    }
    
}
