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
    public int idCategory { get; set; }
    public bool active { get; set; }
    public string productName { get; set; }
    public string description { get; set; }
    public decimal cost { get; set; }
    public decimal blocked { get; set; }
    public List<ProductImage> ProductImages;
    
}