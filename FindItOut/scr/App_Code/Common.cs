using System;
using System.Text;
using System.Data;
using System.Collections.Generic;
using System.IO;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Security.Cryptography;


/// <summary>
/// Descripción breve de Common
/// </summary>
public static class Common
{    
    //correo de envio de pass o token
    public static void SendMailByDictionary(Dictionary<string, string> dicEmailInfo, Dictionary<string, Stream> dicFiles, string emailTo, String Key, string pass)
    {
        clsEmail email = new clsEmail(Key);
        try
        {

            email.setMessage(dicEmailInfo);
            email.setFiles(dicFiles);
            email.ToAdress = emailTo;
            email.Send(pass);
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }

    //correo para solicitar confirmación de cuenta
    public static void SendMailByDictionary(Dictionary<string, string> dicEmailInfo, Dictionary<string, Stream> dicFiles, string emailTo, String Key, string mail, string token)
    {
        clsEmail email = new clsEmail(Key);
        try
        {

            email.setMessage(dicEmailInfo);
            email.setFiles(dicFiles);
            email.ToAdress = emailTo;
            email.Send(mail, token);
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    

    //codificacion de cadena
    public static string  codifica(string cadena)
    {
        byte[] encbuff = System.Text.Encoding.UTF8.GetBytes(cadena);
        
        //nuestro cod revibe y regresa Byts
        encbuff = GetCodeBytes(encbuff);
        
        return Convert.ToBase64String(encbuff);
    }

    static byte[] GetCodeBytes(Byte[] bytes)
    {
        //Byte[] bytes = new byte[str.Length * sizeof(char)];
        //System.Buffer.BlockCopy(str.ToCharArray(), 0, bytes, 0, bytes.Length);
        // Byte[] bytes1 = new byte[str.Length * sizeof(char)];
        int i = 0;
        foreach (Byte b in bytes)
        {
            bytes[i] = (byte)((int)bytes[i] + 10);
            i++;
        }

        return bytes;
    }


    //decodificar
    public static string decodifica(string cadena)
    {        
        try
        {
            byte[] decbuff = Convert.FromBase64String(cadena);
            //decodificar d enosotros
            decbuff = GetDecodeBytes(decbuff);

            return System.Text.Encoding.UTF8.GetString(decbuff);
        }
        catch
        {
            { return ""; }
        }
    }
    static byte[] GetDecodeBytes(Byte[] bytes)
    {        
        int i = 0;

        foreach (Byte b in bytes)
        {
            bytes[i] = (byte)((int)bytes[i] - 10);
            i++;
        }
        return bytes;
    }

    public static string GetSHA1(string str)
    {
        SHA1 sha1 = SHA1Managed.Create();
        ASCIIEncoding encoding = new ASCIIEncoding();
        byte[] stream = null;
        StringBuilder sb = new StringBuilder();
        stream = sha1.ComputeHash(encoding.GetBytes(str));
        for (int i = 0; i < stream.Length; i++) sb.AppendFormat("{0:x2}", stream[i]);
        return sb.ToString();
    }


    static string GetString(byte[] bytes)
    {
        char[] chars = new char[bytes.Length / sizeof(char)];
        System.Buffer.BlockCopy(bytes, 0, chars, 0, bytes.Length);
        return new string(chars);
    }

    public static string creaCarpetaEmpresa(string empre, string inicio, string carpSucu, string carpLogo)
    {
        //empre = "   Maritza de JesusMorfin Franco ";
        string carpeta = empre.Replace(" ", "") + "-" + Common.GetSHA1(DateTime.Now.ToString());

        //crear carpeta principal
        //string PathDocs = ConfigurationManager.AppSettings["EmpresasFiles"];
        //string inicio = HttpContext.Current.Server.MapPath(PathDocs);
        try
        {
            if (!System.IO.Directory.Exists(inicio))
                System.IO.Directory.CreateDirectory(inicio);
        }
        catch (Exception ex)
        {
        }

        //crear carpeta cliente
        string carpetaCliente = inicio + carpeta;
        try
        {
            if (!System.IO.Directory.Exists(carpetaCliente))
                System.IO.Directory.CreateDirectory(carpetaCliente);

            //crear carpeta para las sucursales
            if (!System.IO.Directory.Exists(carpetaCliente + "\\" + carpSucu))
                System.IO.Directory.CreateDirectory(carpetaCliente +"\\"+carpSucu);

            //crear carpeta para logos
            if (!System.IO.Directory.Exists(carpetaCliente + "\\" + carpLogo))
                System.IO.Directory.CreateDirectory(carpetaCliente  +"\\"+ carpLogo );
        }
        catch (Exception ex)
        {
        }      
        return carpeta;
    }

    public static string creaCarpetaSucursales(string carpeta, string inicio, string carpSucu)
    {        
        try
        {
            if (!System.IO.Directory.Exists(inicio))
                System.IO.Directory.CreateDirectory(inicio);
        }
        catch (Exception ex)
        {
        }

        //crear carpeta cliente
        string carpetaCliente = inicio + carpeta;
        try
        {  
            //crear carpeta para las sucursales
            if (!System.IO.Directory.Exists(carpetaCliente + "\\" + carpSucu))
                System.IO.Directory.CreateDirectory(carpetaCliente + "\\" + carpSucu);           
        }
        catch (Exception ex)
        {
            return "error";
        }
        return "";
    }

    #region validaciones de campos

    //entero + o -   
    public static bool validaEntero(string cadena)
    {
        int numero;
        if (Int32.TryParse(cadena, out numero))
            return true;        
        return false;
    }
    //entero +
    public static bool validaEnteroPositivo(string cadena)
    {
        int numero;
        if (Int32.TryParse(cadena, out numero))
        {
            if(numero >= 0)
                return true;
        }
        return false;
    }
    //decimal + o -   
    public static bool validaDecimal(string cadena)
    {
        decimal numero;
        if (Decimal.TryParse(cadena, out numero))
            return true;
        return false;
    }
    //decimal +
    public static bool validaDecimalPositivo(string cadena)
    {
        decimal numero;
        if (Decimal.TryParse(cadena, out numero))
        {
            if (numero >= 0)
                return true;
        }
        return false;

    }
    //valida formato fecha
    public static bool validaFormatoFecha(string cadena)
    {
        DateTime fecha;
        if (DateTime.TryParse(cadena, out fecha))
        {
            return true;
        } 
        return false;

    }    

    //validar email
    public static bool IsValidEmail(string strIn)
    {

        if (String.IsNullOrEmpty(strIn))
            return false;
        // Return true if strIn is in valid e-mail format.
        try
        {
            return Regex.IsMatch(strIn,
                  @"^(?("")(""[^""]+?""@)|(([0-9a-z]((\.(?!\.))|[-!#\$%&'\*\+/=\?\^`\{\}\|~\w])*)(?<=[0-9a-z])@))" +
                  @"(?(\[)(\[(\d{1,3}\.){3}\d{1,3}\])|(([0-9a-z][-\w]*[0-9a-z]*\.)+[a-z0-9]{2,17}))$",
                  RegexOptions.IgnoreCase);
        }
        catch (Exception e)
        {           
            return false;
        }
    }
    #endregion
}
