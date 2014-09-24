<%@ Page Language="C#" AutoEventWireup="true" CodeFile="facebookproof.aspx.cs" Inherits="pruebas_facebookproof" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

     <script type="text/javascript">


         $(function () {
             window.fbAsyncInit = function () {
                 FB.init({
                     appId: '772335249490789',
                     xfbml: true,
                     status: 0,
                     version: 'v2.1'
                 });
             };

             (function (d, s, id) {
                 var js, fjs = d.getElementsByTagName(s)[0];
                 if (d.getElementById(id)) { return; }
                 js = d.createElement(s); js.id = id;
                 js.src = "//connect.facebook.net/es_LA/sdk.js";
                 fjs.parentNode.insertBefore(js, fjs);
             } (document, 'script', 'facebook-jssdk'));

         });
         
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div
  class="fb-like"
  data-send="true"
  data-width="450"
  data-show-faces="true">
</div>
<div id="fb-root"></div>
    </div>
    </form>
</body>
</html>
