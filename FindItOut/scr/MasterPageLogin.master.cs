using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPageLogin : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
       // crearMenu();
    }

    //private void crearMenu()
    //{
    //   LiteralControl menu = new LiteralControl(
    //      "<li class=\"selected\"><a href=\"../Start/Inicio.aspx\">" + GetGlobalResourceObject("GlobalResource", "menuInicio") + "</a></li> " +
    //      "<li><a href=\"../Start/Inicio.aspx\" >" + GetGlobalResourceObject("GlobalResource", "menuBuscar") + "</a></li>" +
    //     // "<li><a href=\"../Start/Registro1.aspx\" >" + GetGlobalResourceObject("GlobalResource", "menuRegistro") + "</a></li>" +
    //      "<li><a href=\"../Start/Nosotros.aspx\">" + GetGlobalResourceObject("GlobalResource", "menuNosotros") + "</a></li>" +
    //      "<li><a href=\"../Start/Contacto.aspx\">" + GetGlobalResourceObject("GlobalResource", "menuContacto") + "</a></li>"
    //      //"<li><a href=\"#\">Example Drop Down</a>"+
    //      //"  <ul>"+
    //      //"    <li><a href=\"#\">Drop Down One</a></li>"+
    //      //"    <li><a href=\"#\">Drop Down Two</a>"+
    //      //"      <ul>"+
    //      //"        <li><a href=\"#\">Sub Drop Down One</a></li>"+
    //      //"        <li><a href=\"#\">Sub Drop Down Two</a></li>"+
    //      //"        <li><a href=\"#\">Sub Drop Down Three</a></li>"+
    //      //"        <li><a href=\"#\">Sub Drop Down Four</a></li>"+
    //      //"        <li><a href=\"#\">Sub Drop Down Five</a></li>"+
    //      //"      </ul>"+
    //      //"    </li>"+
    //      //"    <li><a href=\"#\">Drop Down Three</a></li>"+
    //      //"    <li><a href=\"#\">Drop Down Four</a></li>"+
    //      //"    <li><a href=\"#\">Drop Down Five</a></li>"+
    //      //"  </ul>"+
    //      //"</li>"
    //    );
    //   nav.Controls.Add(menu);
    //}
}
