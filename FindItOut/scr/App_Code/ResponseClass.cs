using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Response
/// </summary>
public class ResponseClass
{
    string result;
    string data;

    public string Data
    {
        get { return data; }
        set { data = value; }
    }

    public string Result
    {
        get { return result; }
        set { result = value; }
    }
    public ResponseClass()
	{
        

		//
		// TODO: Add constructor logic here
		//
	}
}