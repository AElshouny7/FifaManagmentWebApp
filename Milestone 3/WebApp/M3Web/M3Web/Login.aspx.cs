using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;


namespace M3Web
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Login_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string username = login_username_textbox.Text;
            string password = login_password_textbox.Text;

            conn.Open();
            SqlCommand searchSA = new SqlCommand("SELECT * FROM SystemUser , System_Admin WHERE SystemUser.username = System_Admin.username AND SystemUser.username = '" + username + "' AND SystemUser.password = '" + password + "'", conn);
            SqlDataReader resultSA = searchSA.ExecuteReader();
            SqlCommand searchSAM = new SqlCommand("SELECT * FROM SystemUser , Sports_Association_Manager WHERE SystemUser.username = Sports_Association_Manager.username AND SystemUser.username = '" + username + "' AND SystemUser.password = '" + password + "'", conn);
            SqlDataReader resultSAM = searchSAM.ExecuteReader();
            SqlCommand searchCR = new SqlCommand("SELECT * FROM SystemUser , Club_representative WHERE SystemUser.username = Club_representative.username AND SystemUser.username = '" + username + "' AND SystemUser.password = '" + password + "'", conn);
            SqlDataReader resultCR = searchCR.ExecuteReader();
            SqlCommand searchSM = new SqlCommand("SELECT * FROM SystemUser , Stadium_Manager WHERE SystemUser.username = Stadium_Manager.username AND SystemUser.username = '" + username + "' AND SystemUser.password = '" + password + "'", conn);
            SqlDataReader resultSM = searchSM.ExecuteReader();
            SqlCommand searchF = new SqlCommand("SELECT * FROM SystemUser , Fan WHERE SystemUser.username = Fan.username AND SystemUser.username = '" + username + "' AND SystemUser.password = '" + password + "'", conn);
            SqlDataReader resultF = searchF.ExecuteReader();

            try
            {
                if (resultSA.Read())
                {
                    Session["username"] = username;
                    Response.Redirect("~/System_Admin.aspx");
                }
                else if (resultSAM.Read())
                {
                    Session["username"] = username;
                    Response.Redirect("~/Sports_Association_Manager.aspx");
                }
                else if (resultCR.Read())
                {
                    Session["username"] = username;
                    Response.Redirect("~/Club_representative.aspx");
                }
                else if (resultSM.Read())
                {
                    Session["username"] = username;
                    Response.Redirect("~/Stadium_Manager.aspx");
                }
                else if (resultF.Read())
                {
                    SqlCommand checker = new SqlCommand("SELECT * FROM SystemUser , Fan WHERE Fan.status = 0 AND SystemUser.username = Fan.username AND SystemUser.username = '" + username + "' AND SystemUser.password = '" + password + "'", conn);
                    SqlDataReader rdrchecker = checker.ExecuteReader();
                    if (rdrchecker.Read())
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('You are Blocked!')", true);
                    else
                    {
                        Session["username"] = username;
                        Response.Redirect("~/Fan.aspx");
                    }
                   
                }
                else
                {

                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Wrong Credentials!')", true);
                }
                conn.Close();
            }
            catch (Exception ex)
            {

                Response.Write(ex.Message);
            }
        }
    }
}