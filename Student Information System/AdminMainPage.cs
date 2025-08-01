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


namespace Student_Information_System
{
    public partial class AdminMainPage : Form
    {
        private string username;
        public AdminMainPage(string Username)
        {
            InitializeComponent();
            this.username = Username;
        }

        private void webView21_Click(object sender, EventArgs e)
        {

        }

        private void Dashboard_Load(object sender, EventArgs e)
        {
            
            string htmlPath = Path.Combine(Application.StartupPath, "Frontend", "AdminUI-HTML", "Admin-Dashboard.html");

            webView21.Source = new Uri(htmlPath);

            webView21.CoreWebView2InitializationCompleted += (s, args) =>
            {
                webView21.CoreWebView2.NavigationCompleted += (sender2, e2) =>
                {
                    var message = JsonSerializer.Serialize(new { username = this.username });
                    webView21.CoreWebView2.PostWebMessageAsJson(message);
                };

                webView21.CoreWebView2.WebMessageReceived += (sender3, e3) =>
                {
                    try
                    {
                        var messageJson = JsonDocument.Parse(e3.WebMessageAsJson);
                        var root = messageJson.RootElement;

                        if (root.TryGetProperty("action", out JsonElement actionProp))
                        {
                            string action = actionProp.GetString();

                            if (action == "logout")
                            {
                                this.Invoke(new MethodInvoker(() =>
                                {
                                    this.Hide();
                                    new Form1().Show();
                                }));
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Error handling logout: " + ex.Message);
                    }
                };
            };
        }

    }
}
