using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Text.Json;
using System.Data.SqlClient;

namespace Student_Information_System
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void webView21_Click(object sender, EventArgs e)
        {
            
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            string htmlPath = Path.Combine(Application.StartupPath, "Frontend", "index.html");
            webView21.Source = new Uri(htmlPath);

            webView21.WebMessageReceived += WebView21_WebMessageReceived;

        }

        private void WebView21_WebMessageReceived(object sender, Microsoft.Web.WebView2.Core.CoreWebView2WebMessageReceivedEventArgs e)
        {
            try
            {
                // Deserialize the JSON message
                var data = JsonSerializer.Deserialize<Dictionary<string, string>>(e.WebMessageAsJson);

                string username = data["Username"];
                string password = data["Password"];

                string connection = "Data Source=SHENRON\\SQLEXPRESS;Initial Catalog=SIS;Integrated Security=True;TrustServerCertificate=True";
                string query = @"SELECT ul.username, ul.password_hash, r.role
                 FROM User_Login ul
                 JOIN Role r ON ul.role_id = r.role_id
                 WHERE ul.username = @username AND ul.password_hash = @password";


                //MessageBox.Show($"Username: {username}\nPassword: {password}", "Received from HTML");
                try
                {
                    using (SqlConnection conn = new SqlConnection(connection))
                    {
                        conn.Open();
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@username", username);
                            cmd.Parameters.AddWithValue("@password", password);

                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    string role = reader["role"].ToString();
                                    MessageBox.Show($"Welcome, {username}! You are logged in as {role}.", "Login Success");

                                    Dashboard dashboard = new Dashboard();
                                    dashboard.Show();
                                    //this.Hide(); // optional: hide the login form
                                }
                                else
                                {
                                    MessageBox.Show("Invalid credentials.", "Login Failed");
                                }
                            }
                        }
                    }
                }
                catch(Exception ex)
                {
                    MessageBox.Show($"Error: {ex.Message}");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }
    }
}
