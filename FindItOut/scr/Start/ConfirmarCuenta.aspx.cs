using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Start_ConfirmarCuenta : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string token = Request.QueryString["t"];
        //string mail = Request.QueryString["m"];
        //string id = Request.QueryString["i"];
        //string pass = Request.QueryString["p"];

        //decodificar
        //mail = Common.decodifica(mail);
        //id = Common.decodifica(id);
        //pass = Common.decodifica(pass);

        Dictionary<string, object> parameters = new System.Collections.Generic.Dictionary<string, object>();
        //parameters.Add("@mail", mail);
        //parameters.Add("@pass", pass);
        //parameters.Add("@id", id);
        parameters.Add("@token", token);
        string result = "";
        try
        {
            result = DataAccess.executeStoreProcedureString("spr_ACTIVAR_Usuario", parameters);
        }
        catch (Exception ex)
        {
        }
        if (result == "activado")
        {
            lblBienvenida.Text = Resources.GlobalResource.Bienvenida_ConfirmarCuenta;
            lblMessg.Text = Resources.GlobalResource.lbl_MssgConfirmarCuenta;
        }
        else
        {
            lblBienvenida.Text = Resources.GlobalResource.Bienvenida_ConfirmarCuentaError;
            lblMessg.Text = Resources.GlobalResource.lbl_MssgConfirmarCuentaError;           
        }

    }
}