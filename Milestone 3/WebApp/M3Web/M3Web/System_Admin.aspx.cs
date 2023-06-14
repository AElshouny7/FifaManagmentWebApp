using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace M3Web
{
    public partial class System_Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


        }

        public string getClubsData()
        {
            string htmlStr = "";
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            conn.Open();
            SqlCommand clubs = new SqlCommand("SELECT * FROM allClubs", conn);
            SqlDataReader rdrClubs = clubs.ExecuteReader();
            while (rdrClubs.Read())
            {
                string name = rdrClubs.GetString(0);
                string location = rdrClubs.GetString(1);
                htmlStr += "<tr><td>" + name + "</td><td>" + location + "</td><td>";
            }
            conn.Close();
            return htmlStr;
        }

        public string getStadiumData()
        {
            string htmlStr = "";
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            conn.Open();
            SqlCommand stadiums = new SqlCommand("SELECT * FROM allStadiums", conn);
            SqlDataReader rdrStadiums = stadiums.ExecuteReader();
            while (rdrStadiums.Read())
            {
                string name = rdrStadiums.GetString(0);
                string location = rdrStadiums.GetString(1);
                htmlStr += "<tr><td>" + name + "</td><td>" + location + "</td><td>";
            }
            conn.Close();
            return htmlStr;
        }

        public string getFanData()
        {
            string htmlStr = "";
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            conn.Open();
            SqlCommand fans = new SqlCommand("SELECT * FROM allFans", conn);
            SqlDataReader rdrFans = fans.ExecuteReader();
            while (rdrFans.Read())
            {
                string username = rdrFans.GetString(0);
                string password = rdrFans.GetString(1);
                string name = rdrFans.GetString(2);
                string nationalID = rdrFans.GetString(3);
                DateTime birthDate = rdrFans.GetDateTime(4);
                string status = (bool)rdrFans.GetBoolean(5) ? "Unblocked" : "Blocked";





                htmlStr += "<tr><td>" + username + "</td><td>" + password + "</td><td>" + name + "</td><td>" + nationalID + "</td><td>" + birthDate + "</td><td>" + status + "</td><td>";
            }
            conn.Close();
            return htmlStr;
        }

        protected void Panel_Selection_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (Panel_Selection.SelectedIndex)
            {
                case 0:
                    SystemAdminClub.Visible = true;
                    SystemAdminStadiums.Visible = false;
                    SystemAdminFans.Visible = false;
                    break;
                case 1:
                    SystemAdminClub.Visible = false;
                    SystemAdminStadiums.Visible = true;
                    SystemAdminFans.Visible = false;
                    break;
                case 2:
                    SystemAdminClub.Visible = false;
                    SystemAdminStadiums.Visible = false;
                    SystemAdminFans.Visible = true;
                    break;

                default:
                    SystemAdminClub.Visible = false;
                    SystemAdminStadiums.Visible = false;
                    SystemAdminFans.Visible = false;
                    break;
            }

        }

        protected void SystemAdminClubAdd_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string name = SystemAdminClubName.Text;
            string location = SystemAdminClubLocation.Text;

            if (name == "" || location == "")
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Enter Credentials!')", true);
            else
            {
                SqlCommand addC = new SqlCommand("addClub", conn);
                addC.CommandType = CommandType.StoredProcedure;
                addC.Parameters.Add(new SqlParameter("@club_name", name));
                addC.Parameters.Add(new SqlParameter("@club_location", location));

                conn.Open();
                addC.ExecuteNonQuery();
                conn.Close();
            }


        }

        protected void SystemAdminClubDelete_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string name = SystemAdminClubName.Text;

            if (name == "")
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Enter Name!')", true);
            else
            {
                conn.Open();
                SqlCommand checker = new SqlCommand("SELECT name FROM Club WHERE name ='" + name + "'", conn);
                SqlDataReader rdrChecker = checker.ExecuteReader();
                if (rdrChecker.Read())
                {
                    SqlCommand deleteC = new SqlCommand("deleteClub", conn);
                    deleteC.CommandType = CommandType.StoredProcedure;
                    deleteC.Parameters.Add(new SqlParameter("@club_name", name));


                    deleteC.ExecuteNonQuery();
                    conn.Close();
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Club Doesn't Exist!')", true);
                }
            }

        }


        protected void SystemAdminStadiumDelete_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string name = SystemAdminStadiumName.Text;

            conn.Open();
            SqlCommand checker = new SqlCommand("SELECT * FROM Stadium WHERE name ='" + name + "'", conn);
            SqlDataReader rdrChecker = checker.ExecuteReader();
            if (!rdrChecker.Read())
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Stadium Doesn't Exist!')", true);
            }
            else
            {
                SqlCommand deleteS = new SqlCommand("deleteStadium", conn);
                deleteS.CommandType = CommandType.StoredProcedure;
                deleteS.Parameters.Add(new SqlParameter("@stadium_name", name));

                deleteS.ExecuteNonQuery();
            }

            conn.Close();
        }

        protected void SystemAdminStadiumAdd_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string name = SystemAdminStadiumName.Text;
            string location = SystemAdminStadiumLocation.Text;
            int capacity = 0;
            if (SystemAdminStadiumCapacity.Text != "")
                capacity = Int32.Parse(SystemAdminStadiumCapacity.Text);
            else if (capacity == 0)
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Capacity Can't be 0!')", true);
            else
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Enter Capacity!')", true);

            if (name == "" || location == "")
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Enter Credentials!')", true);
            else
            {
                SqlCommand addS = new SqlCommand("addStadium", conn);
                addS.CommandType = CommandType.StoredProcedure;
                addS.Parameters.Add(new SqlParameter("@stadium_name", name));
                addS.Parameters.Add(new SqlParameter("@stadium_location", location));
                addS.Parameters.Add(new SqlParameter("@capacity", capacity));

                conn.Open();
                addS.ExecuteNonQuery();
                conn.Close();
            }


        }

        protected void SystemAdminFanBlock_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string nationalID = SystemAdminFanNationalIDDropList.SelectedValue;

            SqlCommand blockF = new SqlCommand("blockFan", conn);
            blockF.CommandType = CommandType.StoredProcedure;
            blockF.Parameters.Add(new SqlParameter("@fan_id", nationalID));

            conn.Open();
            blockF.ExecuteNonQuery();
            conn.Close();
        }
        protected void SystemAdminFanUnblock_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string nationalID = SystemAdminFanNationalIDDropList.SelectedValue;

            SqlCommand unblockF = new SqlCommand("unblockFan", conn);
            unblockF.CommandType = CommandType.StoredProcedure;
            unblockF.Parameters.Add(new SqlParameter("@fan_id", nationalID));

            conn.Open();
            unblockF.ExecuteNonQuery();
            conn.Close();
        }


    }
}
