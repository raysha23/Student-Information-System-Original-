using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using System.Windows.Forms;


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
            return;

        }

        private void Dashboard_Load(object sender, EventArgs e)
        {
            string htmlPath = Path.Combine(Application.StartupPath, "Frontend", "AdminUI-HTML", "Admin-Dashboard.html");
            webView21.Source = new Uri(htmlPath);


        }

        private void webView21_WebMessageReceived(object sender, Microsoft.Web.WebView2.Core.CoreWebView2WebMessageReceivedEventArgs e)
        {
            var message = e.WebMessageAsJson;
            JObject request = JObject.Parse(message);

            switch ((string)request["type"])
            {
                case "getStudents":
                    var conn = new SqlConnection("Data Source=LAB4-PC26\\LAB2PC45;Initial Catalog=SIS;Integrated Security=True;TrustServerCertificate=True");
                    conn.Open();

                    var cmd = new SqlCommand($"SELECT t.idNumber, t.firstName, t.lastName, g.gender, t.dateOfBirth, t.email, t.phone, t.address, t.enrollmentDate FROM Student t INNER JOIN Gender g ON g.genderId = t.genderId WHERE t.status = 1", conn);
                    var reader = cmd.ExecuteReader();

                    var rows = new List<Dictionary<string, object>>();

                    while (reader.Read())
                    {
                        var row = new Dictionary<string, object>();
                        for (int i = 0; i < reader.FieldCount; i++)
                            row[reader.GetName(i)] = reader.GetValue(i);
                        rows.Add(row);
                    }

                    conn.Close();
                    webView21.CoreWebView2.PostWebMessageAsJson(JsonConvert.SerializeObject(new Dictionary<string, object>
                    {
                        ["columns"] = reader.GetColumnSchema().Select(c => c.ColumnName),
                        ["rows"] = rows
                    }));
                    break;
            }
        }
    }
}
