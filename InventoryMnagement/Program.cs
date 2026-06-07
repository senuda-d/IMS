using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace InventoryMnagement
{
    internal class Program
    {
        static void Main(string[] args)
        {
            SqlConnection con = new SqlConnection(@"Data Source=.\SQLEXPRESS;Initial Catalog=inventorydb;Integrated Security=True;TrustServerCertificate=True");
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);


            Application.Run(new SplashForm());
            
        }
    }
}
