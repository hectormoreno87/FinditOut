﻿function EnterosPositivos(e) {
    var key;
    if (window.event) // IE
    {
        key = e.keyCode;
    }
    else if (e.which) // Netscape/Firefox/Opera
    {
        key = e.which;
    }
    if (key < 48 || key > 57) {
        return false;
    }
    return true;
}

function DecimalesPositivos(e) {
    var key;
    if (window.event) // IE
    {
        key = e.keyCode;
    }
    else if (e.which) // Netscape/Firefox/Opera
    {
        key = e.which;
    }
    if (key < 48 || key > 57) {
        if (key != 46)
            return false;
    }
    return true;
}

function validarVacio(campo) {

    if ((campo.length) == 0)
        return false;
    else
        return true;
}

function validarEmail(email) {
    expr = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    if (!expr.test(email))
        return false;
    else
        return true;
}

function limita(obj, elEvento, maxi) {
    var elem = obj;

    var evento = elEvento || window.event

    var cod = evento.charCode || evento.keyCode;


    if (cod == undefined) {
        cuenta(obj, elEvento, maxi);
        return false;
    }
    else {
        // 37 izquierda
        // 38 arriba
        // 39 derecha
        // 40 abajo
        // 8  backspace
        // 46 suprimir

        if (cod == 37 || cod == 38 || cod == 39
  || cod == 40 || cod == 8 || cod == 46) {
            return true;
        }

        if (elem.value.length < maxi) {
            return true;
        }

        return false;
    }
}

function cuenta(obj, evento, maxi) {
    var elem = obj.value;
    if (elem.length > maxi) {
        obj.value = obj.value.substring(0, maxi)
    }
}

function esImagen(archivo) {
    var extensiones_permitidas = new Array(".gif", ".jpg", ".png", ".jpeg");
    var mierror = "NoEvaluado";
    
    if (!archivo) {
        //Si no tengo archivo, es que no se ha seleccionado un archivo en el formulario 
        mierror = "NoArchivo";
    } 
    else {
        //recupero la extensión de este nombre de archivo 
        var extension = (archivo.substring(archivo.lastIndexOf("."))).toLowerCase();
        //compruebo si la extensión está entre las permitidas 
        var permitida = false;
        for (var i = 0; i < extensiones_permitidas.length; i++) {
            if (extensiones_permitidas[i] == extension) {
                permitida = true;
                break;
            }
        }
        if (!permitida) {
            mierror = "NoExtension";
        }
        else {
            //Todo bien
            mierror = "Ok";
        }
    }
    return mierror;
}