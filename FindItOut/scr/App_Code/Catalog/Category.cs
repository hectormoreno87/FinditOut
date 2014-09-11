using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

public class Category
{
    public int idCategory { get; set; }
    public bool active { get; set; }
    public string categoryName { get; set; }
    public List<Product> Products;
}
