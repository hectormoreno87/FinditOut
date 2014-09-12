﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="menuDesplegable.aspx.cs"
    Inherits="pruebas_menuDesplegable" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Cómo crear un menú de pestañas elegante en jQuery</title>
  
</head>
<body>
    <div class="wrapper">
        <h1>
            Creando un menú desplegable en jQuery</h1>
        <ul class="dropdown">
            <li class="active">Visualizando: <span>Tutoriales</span></li>
            <li class="first"><a href="#">Recursos</a></li>
            <li><a href="#">Inspiración</a></li>
            <li><a href="#">Contacto</a></li>
            <li class="last"><a href="#">Ver más...</a></li>
        </ul>
    </div>   
    <script src="../Scripts/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-1.11.1.min.js" type="text/javascript"></script>
</body>
</html>


<style type="text/css">
    html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em, font, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td
    {
        border: 0pt none;
        font-family: inherit;
        font-size: 100%;
        font-style: inherit;
        font-weight: inherit;
        margin: 0pt;
        padding: 0pt;
        vertical-align: baseline;
    }
    body
    {
        line-height: 1em;
        font-size: 14px;
        font-family: Arial, Helvetica, sans-serif;
        margin: 0pt;
        cursor: default;
        color: #fff;
        background: #262626 url("bg.png") repeat scroll 0 0;
    }
    table
    {
        border-collapse: separate;
        border-spacing: 0pt;
    }
    strong
    {
        font-weight: 700;
    }
    caption, th, td
    {
        font-weight: normal;
        text-align: left;
    }
    blockquote:before, blockquote:after, q:before, q:after
    {
        content: "";
    }
    blockquote, q
    {
        quotes: "" "";
    }
    pre
    {
        font-family: Arial, Helvetica, sans-serif;
    }
    input
    {
        border: 0;
        margin: 0;
        font-family: Arial, Helvetica, sans-serif;
    }
    textarea
    {
        font-family: Arial, Helvetica, sans-serif;
        color: #888888;
        padding: 7px 3px 0 4px;
        font-size: 11px;
    }
    select
    {
        font-size: 11px;
        color: #888888;
        background: #fff;
        font-family: Arial, Helvetica, sans-serif;
        border: 1px solid #CAD2CE;
    }
    ul
    {
        list-style: none;
        list-style-type: none;
        list-style-position: outside;
    }
    a
    {
        cursor: pointer;
        color: #ece6bd;
        text-decoration: underline;
        outline: none !important;
    }
    html, body
    {
        height: 100%;
    }
    .clear
    {
        clear: both;
        height: 0;
        visibility: hidden;
        display: block;
        line-height: 0;
    }
    .clearfix
    {
        overflow: hidden;
    }
    .italic
    {
        font-style: italic;
    }
    /******* /GENERAL RESET *******/
    /******* GENERAL *******/
    h1
    {
        color: #fff;
        font-size: 26px;
        line-height: 3em;
    }
    h2
    {
        line-height: 2em;
        margin-top: 30px;
        margin-bottom: 20px;
        color: #e4e1cd;
    }
    .wrapper
    {
        width: 982px;
        margin: 0pt auto;
        padding-top: 10px;
    }
    /******* /GENERAL *******/
    /******* CONTENT *******/
    h3
    {
        line-height: 1em;
        vertical-align: middle;
        height: 48px;
        padding: 10px 10px 10px 52px;
        font-size: 32px;
        color: #E4E1CD;
    }
    /******* /CONTENT *******/
    /******* MENU *******/
    ul.dropdown
    {
        width: 200px;
        border: 1px solid #000;
        border-radius: 5px;
        -moz-border-radius: 5px;
        -webkit-border-radius: 5px;
        background: #1a1a1a;
        margin-top: 2em;
    }
    ul.dropdown li
    {
        display: none;
        font-size: 12px;
    }
    ul.dropdown li.active
    {
        display: block;
        color: #8c8c8c;
        font-size: 14px;
        padding: 12px;
        color: #555;
        border-top: 1px solid #313131;
        border-radius: 4px;
        -moz-border-radius: 4px;
        -webkit-border-radius: 4px;
    }
    ul.dropdown li.active span
    {
        background: transparent url("dropdown.png") no-repeat scroll right center;
        padding-right: 24px;
        color: #8c8c8c;
    }
    ul.dropdown li a
    {
        display: block;
        text-decoration: none;
        padding: 8px 8px 8px 10px;
        background: #1e1e1e;
        border-bottom: 1px solid #171717;
    }
    ul.dropdown li.last a
    {
        border: 0;
    }
    ul.dropdown li.first a
    {
        border-top: 3px solid #131313;
    }
    ul.dropdown li a:hover
    {
        background: #232323;
        color: #fff;
        padding-left: 11px;
    }
    /******* /MENU *******/
</style>

<script type="text/javascript">

    //variable global para controles dropdown
    var menu = $("ul.dropdown");
    //control de eventos
    $(this.document).ready(function () {
        menu.mouseover(function () {
            displayOptions($(this).find("li"));
        });
        menu.mouseout(function () {
            hideOptions($(this));
        });
    })
    //funcion que MUESTRA todos los elementos del menu
    function displayOptions(e) {
        e.show();
    }
    //funcion que OCULTA los elementos del menu
    function hideOptions(e) {
        e.find("li").hide();
        e.find("li.active").show();
    }

</script>
