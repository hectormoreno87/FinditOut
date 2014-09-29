<%@ Page Language="C#" AutoEventWireup="true" CodeFile="tooltips.aspx.cs" Inherits="pruebas_tooltips" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>

<script type="text/javascript">// <![CDATA[
    $(document).ready(function () {

        $("#tooltip1").mouseover(function () {
            eleOffset = $(this).offset();

            $(this).next().fadeIn("fast").css({

                left: eleOffset.left + $(this).outerWidth(),
                top: eleOffset.top

            });
        }).mouseout(function () {
            $(this).next().hide();
        });

        $("#tooltip2").mouseover(function () {
            $("#tooltip2").mousemove(function (e) {
                $(this).next().css({ left: e.pageX, top: e.pageY });
            });
            eleOffset = $(this).offset();
            $(this).next().fadeIn("fast").css({

                left: eleOffset.left + $(this).outerWidth(),
                top: eleOffset.top

            });
        }).mouseout(function () {
            $(this).next().fadeOut("fast");
        });

    });		
</script>

    <form id="form1" runat="server">
    <div>
    <a id="tooltip1" href="#">Ejemplo básico de Tooltip</a>
<div class="tooltip">Contenido del Tooltip 1</div>
<a id="tooltip2" href="#">Ejemplo básico de Tooltip con seguimiento</a>
<div class="tooltip-seg">Contenido del Tooltip 1</div>
    </div>
    </form>
</body>
</html>
