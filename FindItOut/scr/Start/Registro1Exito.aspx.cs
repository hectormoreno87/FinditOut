using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class Registro1Exito : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["correoEnviar"] == null || Session["resp"] == null)
        {
            Response.Redirect("Inicio.aspx", false);
        }

        else
        {
            string mail = Session["correoEnviar"].ToString();
            string resp = Session["resp"].ToString();

            Session["correoEnviar"] = null;
            Session["resp"] = null;

            lblTitulo.Text = lblMail.Text = lblCorreo2.Text = lblCorreo1.Text = "";
            lnkRecordarPass.Visible = lnkRegistro.Visible = lnkInicio.Visible = lblMail.Visible = lblCorreo2.Visible = lblCorreo1.Visible = false;


            if (resp == "1")//repetido
            {
                lblTitulo.Text = Resources.GlobalResource.Bienvenida_Registro1Exito2;
                lblCorreo1.Text = Resources.GlobalResource.lbl_correoRepetido;
                lnkRecordarPass.Visible = lnkRegistro.Visible = lblCorreo1.Visible = true;
            }

            if (resp == "3")//guardado
            {                                
                lblTitulo.Text = Resources.GlobalResource.Bienvenida_Registro1Exito;
                lblMail.Text = mail;
                lblCorreo1.Text = Resources.GlobalResource.lbl_correoEnviado1;
                lblCorreo2.Text = Resources.GlobalResource.lbl_correoEnviado2;
                lnkInicio.Visible = lblMail.Visible = lblCorreo2.Visible = lblCorreo1.Visible = true;
            }
        }
    }
}