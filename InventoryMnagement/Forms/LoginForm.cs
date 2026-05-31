using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace InventoryMnagement
{
    public partial class LoginForm : Form
    {
        public LoginForm()
        {
            InitializeComponent();
            FormScaler.ScaleForm(this);
        }

        SqlConnection con = new SqlConnection(@"Data Source=.\SQLEXPRESS;Initial Catalog=inventorydb;Integrated Security=True;TrustServerCertificate=True");

        private void pswdshow_Click(object sender, EventArgs e)
        {
                pwdbox.UseSystemPasswordChar = false;
                pswdshow.BringToFront();
        }

        private void clearButton_Click(object sender, EventArgs e)
        {
            Username.Clear();
            pwdbox.Clear();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void Login_Click(object sender, EventArgs e)
        {
            con.Open();
            SqlDataAdapter sda = new SqlDataAdapter("SELECT COUNT(*) FROM UserTbl WHERE Uname='" + Username.Text + "' AND UPassword='" + pwdbox.Text + "'", con);
            DataTable dt=new DataTable();
            sda.Fill(dt);
            if (dt.Rows[0][0].ToString() == "1")
            {
                 HomeForm home = new HomeForm();
                home.Show();
                this.Hide();
            }
            else
            {
                MessageBox.Show("Wrong Username or Password");
            }
            con.Close();
        }
    }
}
