using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SendPassExito : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["passEnviadoBien"] == null)
        {
            Response.Redirect("Inicio.aspx", false);
        }
        else
        {
            string passEnviadoBien = Session["passEnviadoBien"].ToString();
            Session["passEnviadoBien"] = null;

            lnkSenPass.Visible = lnkInicio.Visible = false;

            if (passEnviadoBien == "true")
            {
                lblTitulo.Text = Resources.GlobalResource.Bienvenida_SendPassExito;
                lblMesg.Text = Resources.GlobalResource.lbl_SendPassExitoMesg;
                lnkInicio.Visible = true;
            }
            else if (passEnviadoBien == "false")
            {
                lblTitulo.Text = Resources.GlobalResource.Bienvenida_SendPassExitoFalse;
                lblMesg.Text = Resources.GlobalResource.lbl_SendPassExitoMesgFalse;
                lnkSenPass.Visible = lnkInicio.Visible = true;

            }
            else if (passEnviadoBien == "noEncontrado")
            {
                lblTitulo.Text = Resources.GlobalResource.Bienvenida_SendPassExitoNoEncontrado;
                lblMesg.Text = Resources.GlobalResource.lbl_SendPassExitoMesgNoEncontrado;
                lnkSenPass.Visible = lnkInicio.Visible = true;
            }
        }
    }
}