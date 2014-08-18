using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Text;

public partial class search_frmSearch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    [WebMethod]
    public static string searchM(object cordenadas, string text, string distance)
    {
        return "[{\"idItem\": 1, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}" +
        ",{\"idItem\": 2, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.4466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}" +
        ",{\"idItem\": 3, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.5466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}" +
        ",{\"idItem\": 4, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.6466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}" +
        ",{\"idItem\": 5, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.7466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}" +
        ",{\"idItem\": 6, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.8466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}" +
        ",{\"idItem\": 7, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-103.9466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}" +
        ",{\"idItem\": 8, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.2466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}" +
        ",{\"idItem\": 9, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}" +
        ",{\"idItem\": 10, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.4466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}" +
        ",{\"idItem\": 11, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.5466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}" +
        ",{\"idItem\": 12, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.2466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}" +
        ",{\"idItem\": 13, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}" +
        ",{\"idItem\": 14, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}" +
        ",{\"idItem\": 15, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}" +
        ",{\"idItem\": 16, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}" +
        ",{\"idItem\": 17, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}" +
        ",{\"idItem\": 18, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}" +
        ",{\"idItem\": 19, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}" +
        ",{\"idItem\": 20, \"idCategory\" : 1, \"name\":\"producto1\", \"category\":\"categoria 1\", \"hasCost\": 1,\"cost\":16.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.3466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}" +
        ",{\"idItem\": 21, \"idCategory\" : 1, \"name\":\"producto2\", \"category\":\"categoria 1\", \"hasCost\":1,\"cost\":20.5,\"active\":1, \"image\":\"http://192.168.1.110/finditout/images/image_1.jpg\"" + ",\"finditoutName\":\"dominio6\",\"distance\":300.3, \"latitude\":\"20.6827248\", \"longitude\":\"-104.6466798\", \"logo\":\"../img/FindOut/FindITOutName/name1.jpg\"}]";

       
    }

   
}