using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GenericResponse
/// </summary>
public class GenericResponse
{
    public bool success { get; set; }
    public string message { get; set; }
    public object obj { get; set; }

}