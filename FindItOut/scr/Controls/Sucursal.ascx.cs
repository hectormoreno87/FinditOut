using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;

public partial class Controls_Sucursal : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        cargaRedesSociales();
    }

    public void cargaRedesSociales()
    {
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
            for (int i =0 ; i< dt.Rows.Count; i++)
            {
                cad += "<tr>";
                //logo
                cad += "<td style=\"width:65px;\">";
                cad += "<img src=\""+dt.Rows[i]["logoRedS"].ToString()+"\" height=\"25\" width=\"25\">";
                cad += "</td>";
                ////lbl
                //cad += "<td>";
                //cad += "<label  for= \"red_" + dt.Rows[i]["idRedS"].ToString() + "\" >" + dt.Rows[i]["nombreRedS"].ToString() + "</label>";
                //cad += "</td>";
                //txt
                cad += "<td>";
                cad += "<input name= \"red_" + dt.Rows[i]["idRedS"].ToString() + "\" class=\"cajaLarga\">";
                cad += "</td>";

                cad += "</tr>";
            }
            cad+="</table>";

             LiteralControl menu = new LiteralControl(cad);
            div_redesS.Controls.Add(menu);
        }
    }

    public void show()
    {
        ltTiTulo.Text = GetGlobalResourceObject("GlobalResource", "Bienvenida_NuevaSucursal").ToString();
        mdlPopupMessageGralControl.Show();
    }
}