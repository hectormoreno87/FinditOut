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
    #region no sé que es esto
    public enum STATUS
    {
        Process,
        User_Response,
        Canceled,
        Solved,
        Diagnostic,
        New,
        Review
    }

    public enum ROLES_USERS
    {
        Data_Owner,
        Application_Manager,
        Infrastructure_Manager,
        Development_Manager,
        Director,
        Ticket_User,
        IT_Responsable
    }

    public enum MESSAGE_TYPE
    {
        Error,
        Info,
        Warning,
        Success
    }

    public enum PRIORITY
    {
        Low,
        Normal,
        High,
        Critical
    }

    public enum DEPARTMENT
    {
        HD,
        IT,
        DE,
        US,
        APP
    }

    public enum RFC_STATUS
    {
        User_Capture,
        IT_Analysis,
        Approval,
        Verification,
        Accepting
    }

    public static int getIDRFCStatusNumber(RFC_STATUS rfcStatus)
    {

        switch (rfcStatus)
        {
            case RFC_STATUS.User_Capture:
                return 1;
            case RFC_STATUS.IT_Analysis:
                return 2;
            case RFC_STATUS.Approval:
                return 3;
            case RFC_STATUS.Verification:
                return 4;
            case RFC_STATUS.Accepting:
                return 5;
            default:
                return 1;
        }
    }

    public static RFC_STATUS getRFCStatusByNumber(int idRfcStatus)
    {
        switch (idRfcStatus)
        {
            case 1:
                return RFC_STATUS.User_Capture;
            case 2:
                return RFC_STATUS.IT_Analysis;
            case 3:
                return RFC_STATUS.Approval;
            case 4:
                return RFC_STATUS.Verification;
            case 5:
                return RFC_STATUS.Accepting;
            default:
                return RFC_STATUS.User_Capture;
        }
    }

    public static int getIDRoleUsersNumber(ROLES_USERS roleUsers)
    {
        switch (roleUsers)
        {
            case ROLES_USERS.Data_Owner:
                return 1;
            case ROLES_USERS.Application_Manager:
                return 2;
            case ROLES_USERS.Infrastructure_Manager:
                return 3;
            case ROLES_USERS.Development_Manager:
                return 4;
            case ROLES_USERS.Director:
                return 5;
            case ROLES_USERS.Ticket_User:
                return 6;
            case ROLES_USERS.IT_Responsable:
                return 7;
        }
        return 6;
    }

    public static ROLES_USERS getRoleUsersByID(int roleUsers)
    {
        switch (roleUsers)
        {
            case 1:
                return ROLES_USERS.Data_Owner;
            case 2:
                return ROLES_USERS.Application_Manager;
            case 3:
                return ROLES_USERS.Infrastructure_Manager;
            case 4:
                return ROLES_USERS.Development_Manager;
            case 5:
                return ROLES_USERS.Director;
            case 6:
                return ROLES_USERS.Ticket_User;
            case 7:
                return ROLES_USERS.IT_Responsable;
        }
        return ROLES_USERS.Ticket_User;
    }


    public static int getIdDepartmentNumber(Common.DEPARTMENT department)
    {
        switch (department)
        {
            case DEPARTMENT.HD:
                return 1;
            case DEPARTMENT.IT:
                return 3;
            case DEPARTMENT.DE:
                return 4;
            case DEPARTMENT.US:
                return 0;
            case DEPARTMENT.APP:
                return 2;
            default:
                return 0;
        }
    }

    public static Common.DEPARTMENT getDepartmentEnum(int department)
    {
        switch (department)
        {
            case 1:
                return DEPARTMENT.HD;
            case 3:
                return DEPARTMENT.IT;
            case 4:
                return DEPARTMENT.DE;
            case 0:
                return DEPARTMENT.US;
            case 2:
                return DEPARTMENT.APP;
            default:
                return DEPARTMENT.US;
        }
    }

    public static int getPriorityNumber(Common.PRIORITY priority)
    {
        switch (priority)
        {
            case PRIORITY.Low:
                return 1;
            case PRIORITY.Normal:
                return 2;
            case PRIORITY.High:
                return 3;
            case PRIORITY.Critical:
                return 4;
            default:
                return 1;
                break;
        }
    }
    public static Common.PRIORITY getPriorityEnumByNumber(int priority)
    {
        switch (priority)
        {
            case 1:
                return PRIORITY.Low;
            case 2:
                return PRIORITY.Normal;
            case 3:
                return PRIORITY.High;
            case 4:
                return PRIORITY.Critical;
            default:
                return PRIORITY.Low;
                break;
        }
    }

    public static int getStatusNumber(Common.STATUS status)
    {
        if (status == STATUS.Solved)
        { return 1; }
        if (status == STATUS.Process)
        { return 2; }
        if (status == STATUS.Canceled)
        { return 3; }
        if (status == STATUS.User_Response)
        { return 4; }
        if (status == STATUS.Diagnostic)
        { return 5; }
        if (status == STATUS.New)
        { return 6; }
        if (status == STATUS.Review)
        { return 7; }
        return 0;

    }

    public static STATUS getStatusByNumber(int idStatus)
    {
        switch (idStatus)
        {
            case 1:
                return STATUS.Solved;
            case 2:
                return STATUS.Process;
            case 3:
                return STATUS.Canceled;
            case 4:
                return STATUS.User_Response;
            case 5:
                return STATUS.Diagnostic;
            case 6:
                return STATUS.New;
            case 7:
                return STATUS.Review;
            default:
                return STATUS.Solved;
        }
    }

    public enum TYPE
    {
        Incident,
        Requirement   
    }

    public enum ActionHD
    {
        Created,
        AddCommentUser,
        AddCommentIT,
        Escalated,
        Critical
    }

    public static int getTypeNumber(Common.TYPE  type)
    {
        if (type == Common.TYPE.Requirement)
        { return 1; }
        if (type == Common.TYPE.Incident)
        { return 2; }
        return 0;
    }

    public static void deleteDirectory(string sourceFile)
    {
        try
        {
            if (sourceFile != "" && Directory.Exists(sourceFile))
            {
                Directory.Delete(sourceFile, true);
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
            
        }
    }

    public static void deleteFile(string sourceFile)
    {
        try
        {
            if (sourceFile != "" && File.Exists(sourceFile))
            {
                File.Delete(sourceFile);
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);   
        }
    }

    public static void makeDirectoryIfNotExists(string NewDirectory)
    {
        try
        {
            if (!Directory.Exists(NewDirectory))
            {
                Directory.CreateDirectory(NewDirectory);
            }
        }
        catch (IOException ex)
        {
            throw ex;
        }
    }

    /// <summary>
    /// If the user has the access to be in this page
    /// </summary>
    /// <param name="department"></param>
    /// <param name="pageName">"IT" IT | "HD" Help Desk | "US" User</param>
    /// <returns></returns>
    public static bool isTheUserAllow(int department, string pageName)
    {
        switch (pageName)
        {
            case "US":
                if (department == 0)
                { return true; }
                else
                { return false; }
            case "IT":
                if (department != 0 && department != 1)
                { return true; }
                else
                { return false; }
            case "HD":
                if (department == 1)
                { return true; }
                else
                { return false; }
            default: return false;
        }
    }

    public static bool isTheUserAdmin(int adminRights)
    {
        return adminRights == 0 ? false : true;
    }

    /// <summary>
    /// Get Infotmation data for Radio Button
    /// </summary>
    /// <param name="english">true to english: false to spanish</param>
    /// <returns></returns>
    public static DataTable getRadioButtonInformation(bool english)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("ID");
        dt.Columns.Add("Description");
        DataRow dr = dt.NewRow();
        dr["ID"] = "1";
        dr["Description"] = english ? "User" : "Usuario";
        dt.Rows.Add(dr);
        dr = dt.NewRow();
        dr["ID"] = "2";
        dr["Description"] = english ? "IT Department" : "Departamento de IT";
        dt.Rows.Add(dr);
        return dt;
    }

    public static DataTable getRadioButtonSearchOptionCreateInformation(bool english)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("ID");
        dt.Columns.Add("Description");
        DataRow dr = dt.NewRow();
        dr["ID"] = "1";
        dr["Description"] = english ? "User Name" : "Nombre de Usuario";
        dt.Rows.Add(dr);
        dr = dt.NewRow();
        dr["ID"] = "2";
        dr["Description"] = english ? "Name" : "Nombre";
        dt.Rows.Add(dr);
        return dt;
    }

    public static DataTable getRadioButtonRFCUserCaputre(bool english)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("ID");
        dt.Columns.Add("Description");
        DataRow dr = dt.NewRow();
        dr["ID"] = "1";
        dr["Description"] = english ? "Corrective Action" : "Acción Correctiva";
        dt.Rows.Add(dr);
        dr = dt.NewRow();
        dr["ID"] = "2";
        dr["Description"] = english ? "Preventive Action" : "Acción Preventiva";
        dt.Rows.Add(dr);
        return dt;
    }

    public static string formatEmailFromDataTable(DataTable dt)
    {
        StringBuilder emailsFormat = new StringBuilder();

        foreach (DataRow item in dt.Rows)
        {
            emailsFormat.Append(item["Email"].ToString());
            emailsFormat.Append(";");
        }
        return emailsFormat.ToString();
    }

    public static string formatEmailFromDataTable(List<string> list)
    {
        StringBuilder emailsFormat = new StringBuilder();

        foreach (string item in list)
        {
            emailsFormat.Append(item);
            emailsFormat.Append(";");
        }
        return emailsFormat.ToString();
    }

    public static string getDateToFile(string fileName)
    {
        StringBuilder sbCadDate = new StringBuilder();
        DateTime dTime = DateTime.Now;
        if (fileName.Length > 50)
        {
            fileName = fileName.Substring(1, 50);
        }
        sbCadDate.Append(fileName);
        sbCadDate.Append(dTime.Year.ToString());
        sbCadDate.Append(dTime.Month.ToString());
        sbCadDate.Append(dTime.Day.ToString());
        sbCadDate.Append(dTime.Hour.ToString());
        sbCadDate.Append(dTime.Minute.ToString());
        sbCadDate.Append(dTime.Second.ToString());

        return sbCadDate.ToString();
    }
     
    public static string getEmailUserHDFromDB(string userName, string connection)
    {
        try
        {
            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("@UserName", userName);
            DataTable dt = DataAccess.executeStoreProcedureDataTable("dbo.sp_getEmailHDAndIT", parameters, connection);
            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0]["Email"].ToString();
            }
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        return "";
    }

    public static DataTable getUserInformationFromDB(string userName, string connection)
    {
        try
        {
            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("@UserName", userName);
            parameters.Add("@Password", "");
            parameters.Add("@Domain", "");
            DataTable dt = DataAccess.executeStoreProcedureDataTable("dbo.sp_getUserLogInformation", parameters, connection);
            return dt.Rows.Count > 0 ? dt : null;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }

   

    public static string getHtmlBodyAssignedCritical(string ticketNumber, string subject, string descripcion, string user, string phone, string leng)
    {
        StringBuilder HTMLbody = new StringBuilder();
        if (leng == "ES")
        {
            HTMLbody.Append("<html>");
            HTMLbody.Append("<body style = \"font-family:Calibri;\">");
            HTMLbody.Append("<p><strong>TICKET CRÍTICO</strong></p>");
            HTMLbody.Append(string.Format("<p>Ticket número: <strong>{0}</strong></p>", ticketNumber));
            HTMLbody.Append(string.Format("<p>ASUNTO: <strong>{0}</strong><br />", subject));
            HTMLbody.Append(string.Format("USUARIO: <strong>{0}</strong><br />", user));
            HTMLbody.Append(string.Format("DESCRIPCIÓN: <strong>{0}</strong><br />", descripcion));
            HTMLbody.Append(string.Format("TELÉFONO: <strong>{0}</strong><br /></p>", phone));
            HTMLbody.Append(string.Format("<a href=\"{1}/frmLogin.aspx\">{0}</a>", 
                                                      System.Configuration.ConfigurationManager.AppSettings.Get("appTitle")
                                                    , System.Configuration.ConfigurationManager.AppSettings.Get("SourceWebPage")));
            HTMLbody.Append("<br/>PITS");
            HTMLbody.Append("</body>");
            HTMLbody.Append("</html>");
        }
        else
        {
            HTMLbody.Append("<html>");
            HTMLbody.Append("<body style = \"font-family:Calibri;\">");
            HTMLbody.Append("<p><strong>TICKET CRÍTICO</strong></p>");
            HTMLbody.Append(string.Format("<p>Ticket número: <strong>{0}</strong></p>", ticketNumber));
            HTMLbody.Append(string.Format("<p>ASUNTO: <strong>{0}</strong><br />", subject));
            HTMLbody.Append(string.Format("USUARIO: <strong>{0}</strong><br />", user));
            HTMLbody.Append(string.Format("DESCRIPCIÓN: <strong>{0}</strong><br />", descripcion));
            HTMLbody.Append(string.Format("TELÉFONO: <strong>{0}</strong><br /></p>", phone));
            HTMLbody.Append(string.Format("<a href=\"{1}/frmLogin.aspx\">{0}</a>", 
                                                      System.Configuration.ConfigurationManager.AppSettings.Get("appTitle")
                                                    , System.Configuration.ConfigurationManager.AppSettings.Get("SourceWebPage")));
            HTMLbody.Append("<br/>PITS");
            HTMLbody.Append("</body>");
            HTMLbody.Append("</html>");

        }
        return HTMLbody.ToString();
    }

    public static string getHtmlBodyEscalation(string ticketNumber, string subject, string descripcion, string user, string phone, string comment, string leng)
    {
        StringBuilder HTMLbody = new StringBuilder();
        //testing
        if (true || leng == "ES")
        {
            HTMLbody.Append("<html>");
            HTMLbody.Append("<body style = \"font-family:Calibri;\">");
            HTMLbody.Append(string.Format("<p>Ticket número: <strong>{0}</strong></p>", ticketNumber));
            HTMLbody.Append("<p><strong>ESTE TICKET FUE ESCALADO PARA TI</strong></p>");
            HTMLbody.Append(string.Format("<p>Comentario: {0}<br /><br />", comment));
            HTMLbody.Append(string.Format("ASUNTO: <strong>{0}</strong><br />", subject));
            HTMLbody.Append(string.Format("USUARIO: <strong>{0}</strong><br />", user));
            HTMLbody.Append(string.Format("DESCRIPCIÓN: <strong>{0}</strong><br />", descripcion));
            HTMLbody.Append(string.Format("TELÉFONO: <strong>{0}</strong><br /></p>", phone));
            HTMLbody.Append(string.Format("<a href=\"{1}/frmLogin.aspx\">{0}</a>", 
                                                      System.Configuration.ConfigurationManager.AppSettings.Get("appTitle")
                                                    , System.Configuration.ConfigurationManager.AppSettings.Get("SourceWebPage")));
            HTMLbody.Append("<br/>PITS");
            HTMLbody.Append("</body>");
            HTMLbody.Append("</html>");
        }
        return HTMLbody.ToString();
    }

    public static string getHtmlBodyNotAgreeToHDManager(string ticketNumber, string userName, string comment, string connection)
    {
        StringBuilder HTMLbody = new StringBuilder();
        DataTable dt = null;
        string leng = "";
        
        try
        {
            Dictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("@idTicket", ticketNumber);
            dt = DataAccess.executeStoreProcedureDataTable("dbo.sp_getTicketInfo", parameters, connection);
        }catch { }

        if (true || leng == "ES")
        {
            HTMLbody.Append("<html>");
            HTMLbody.Append("<body style = \"font-family:Calibri;\">");
            HTMLbody.Append(string.Format("<p>En el ticket: <strong>{0}</strong> que perteneciente al usuario: {1}</p>", ticketNumber,userName));
            HTMLbody.Append(string.Format("<p>No le pareció correcta la decisión de su ticket, por lo cual comentó:<br/>{0}</p>", comment));
            if (dt != null && dt.Rows.Count > 0)
            {
                HTMLbody.Append(string.Format("<p>Cerrado por: {0}", dt.Rows[0]["Responsable"].ToString()));
                HTMLbody.Append(string.Format("<br/>Último Sub-Responsable por: {0}", dt.Rows[0]["AssignedTo"].ToString()));
                HTMLbody.Append(string.Format("<br/>Teléfono del usuario: {0}</p>", dt.Rows[0]["UserPhone"].ToString()));
            }
            HTMLbody.Append(string.Format("<br/><a href=\"{1}/frmLogin.aspx\">{0}</a>", 
                                                              System.Configuration.ConfigurationManager.AppSettings.Get("appTitle")
                                                            , System.Configuration.ConfigurationManager.AppSettings.Get("SourceWebPage")));
            HTMLbody.Append("<br/>PITS");
            HTMLbody.Append("</body>");
            HTMLbody.Append("</html>");
        }
        return HTMLbody.ToString();
    }

    public static string getHtmlBodyNotAgreeToUser(string HDManager, string fullName)
    {
        StringBuilder HTMLbody = new StringBuilder();
        string leng = "";
        HTMLbody.Append("<html>");
        HTMLbody.Append("<body style = \"font-family:Calibri;\">");

        if (leng == "ES")
        {
            HTMLbody.Append(string.Format("<p> {1} Gracias por tu comentario, {0} estará a cargo de este ticket</p>", HDManager, fullName));
        }
        HTMLbody.Append(string.Format("<br/><a href=\"{1}/frmLogin.aspx\">{0}</a>", 
                                                  System.Configuration.ConfigurationManager.AppSettings.Get("appTitle")
                                                , System.Configuration.ConfigurationManager.AppSettings.Get("SourceWebPage")));
        HTMLbody.Append("<br/>PITS");
        HTMLbody.Append("</body>");
        HTMLbody.Append("</html>");

        return HTMLbody.ToString();
    }

    public static string getHtmlBodyCommentToIT(string ticketNumber, string subject, string userHD, string comment, string leng)
    {
        StringBuilder HTMLbody = new StringBuilder();
        //testing
        if (true || leng == "ES")
        {
            HTMLbody.Append("<html>");
            HTMLbody.Append("<body style = \"font-family:Calibri;\">");
            HTMLbody.Append(string.Format("<p>Ticket número: <strong>{0}</strong></p>", ticketNumber));
            HTMLbody.Append(string.Format("<p>{0} Comentó: {1}<br /><br />", userHD, comment));
            HTMLbody.Append(string.Format("ASUNTO: <strong>{0}</strong><br />", subject));
            HTMLbody.Append(string.Format("<a href=\"{1}/frmLogin.aspx\">{0}</a>", 
                                                              System.Configuration.ConfigurationManager.AppSettings.Get("appTitle")
                                                            , System.Configuration.ConfigurationManager.AppSettings.Get("SourceWebPage")));
            HTMLbody.Append("<br/>PITS");
            HTMLbody.Append("</body>");
            HTMLbody.Append("</html>");
        }
        return HTMLbody.ToString();
    }

    public static string cleanScriptTags(string textToClean)
    {
        //textToClean = textToClean.ToLowerInvariant();
        textToClean = textToClean.Replace("<script>", "-script-");
        textToClean = textToClean.Replace("</script>", "-/script-");
        return textToClean;

    }
    
    public static string ConvertSortDirectionToSql( SortDirection sortDirection)
    {
        string newSortDirection = String.Empty;

        switch (sortDirection)
        {
            case SortDirection.Ascending:
                newSortDirection = "ASC";
                break;

            case SortDirection.Descending:
                newSortDirection = "DESC";
                break;
            default:
                newSortDirection = "ASC";
                break;
        }
        return newSortDirection;
    }

    /// <summary>SendMailByDictionary is a method in the MailSend Class.
    /// <para>Allowed String Keys, DataInformation, ApprovedInvoid and RejectedInvoice.</para>
    /// </summary>
    #endregion
    
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

    public static string creaCarpetaEmpresa(string empre, string PathDocs, string inicio)
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
        }
        catch (Exception ex)
        {
        }
        return carpeta;
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
