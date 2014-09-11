using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Class1
/// </summary>
public class Product
{
    public int idProduct { get; set; }
    public bool active { get; set; }
    public string productName { get; set; }
    public List<ProductImage> ProductImages;
    
}