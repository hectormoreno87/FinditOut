function popUp(mensaje, type) {

    switch (type) {
        case 'ok':
            $.get("../utils/htmlPopUp/popUpTemplate.html", function (respons) {


                respons = respons.replace('@@@', mensaje);
                $('#divPop').remove();
                $('#idPopUp1').remove();
                $('body').append(respons);
                $('body').prepend('<div id="idPopUp1" class="modalBackground" >');
                $('#divPop').show();
                $('#idPopUp1').show();
            });


            break;


        case 'save':

            $.ajax({ url: "../utils/htmlPopUp/popUpTemplateCalificarCriterios.html", cache: false, success: function (respons) {
                respons = respons.replace('@@@', mensaje);
                $('#divPop').remove();
                $('#idPopUp1').remove();
                $('body').append(respons);
                $('body').prepend('<div id="idPopUp1" class="modalBackground" >');
                $('#divPop').show();
                $('#idPopUp1').show();
            } 
            });


            break;
    }
}


function ok() {
    $('#divPop').hide();
    $('#idPopUp1').hide();

}

function hidepop() {
    $('#divPop').hide();
    $('#idPopUp1').hide();

}
