using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3Web
{
    public partial class Sports_Association_Manager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Matches_Type_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (Matches_Type.SelectedIndex)
            {
                case 0:
                    SAMAllMatches.Visible = true;
                    SAMAllUpcomingMatches.Visible = false;
                    SAMAllPlayedMatches.Visible = false;
                    SAMNeverVS.Visible = false;
                    break;
                case 1:
                    SAMAllMatches.Visible = false;
                    SAMAllUpcomingMatches.Visible = true;
                    SAMAllPlayedMatches.Visible = false;
                    SAMNeverVS.Visible = false;
                    break;
                case 2:
                    SAMAllMatches.Visible = false;
                    SAMAllUpcomingMatches.Visible = false;
                    SAMAllPlayedMatches.Visible = true;
                    SAMNeverVS.Visible = false;
                    break;
                case 3:
                    SAMAllMatches.Visible = false;
                    SAMAllUpcomingMatches.Visible = false;
                    SAMAllPlayedMatches.Visible = false;
                    SAMNeverVS.Visible = true;
                    break;

                default:
                    SAMAllMatches.Visible = false;
                    SAMAllUpcomingMatches.Visible = false;
                    SAMAllPlayedMatches.Visible = false;
                    SAMNeverVS.Visible = false;
                    break;
            }

        }

        public string getMatchData()
        {
            string htmlStr = "";
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            conn.Open();
            SqlCommand matches = new SqlCommand("SELECT * FROM allMatches", conn);
            SqlDataReader rdrMatches = matches.ExecuteReader();
            while (rdrMatches.Read())
            {
                string hostClub = rdrMatches.GetString(0);
                string guestClub = rdrMatches.GetString(1);
                DateTime startTime = rdrMatches.GetDateTime(2);
                DateTime endTime = rdrMatches.GetDateTime(3);

                htmlStr += "<tr><td>" + hostClub + "</td><td>" + guestClub + "</td><td>" + startTime + "</td><td>" + endTime + "</td><td>";
            }
            conn.Close();
            return htmlStr;
        }

        public string getMatchDataWithDate(String condition)
        {
            string htmlStr = "";
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            conn.Open();
            SqlCommand matches = new SqlCommand("SELECT * FROM allMatches WHERE startsAt " + condition + "GETDATE()", conn);
            SqlDataReader rdrMatches = matches.ExecuteReader();
            while (rdrMatches.Read())
            {
                string hostClub = rdrMatches.GetString(0);
                string guestClub = rdrMatches.GetString(1);
                DateTime startTime = rdrMatches.GetDateTime(2);
                DateTime endTime = rdrMatches.GetDateTime(3);

                htmlStr += "<tr><td>" + hostClub + "</td><td>" + guestClub + "</td><td>" + startTime + "</td><td>" + endTime + "</td><td>";
            }
            conn.Close();
            return htmlStr;
        }

        public string getNeverVSData()
        {
            string htmlStr = "";
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            conn.Open();
            SqlCommand matches = new SqlCommand("SELECT * FROM clubsNeverMatched", conn);
            SqlDataReader rdrMatches = matches.ExecuteReader();
            while (rdrMatches.Read())
            {
                string clubOne = rdrMatches.GetString(0);
                string clubTwo = rdrMatches.GetString(1);

                htmlStr += "<tr><td>" + clubOne + "</td><td>" + clubTwo + "</td><td>";
            }
            conn.Close();
            return htmlStr;
        }

        protected void SAMMatchAdd_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string hostName = SAMHostNameDropList.SelectedValue;
            string guestName = SAMGuestNameDropList.SelectedValue;
            DateTime startTime = DateTime.Parse(SAMStartTime.Text);
            DateTime endTime = DateTime.Parse(SAMEndTime.Text);

            SqlCommand addM = new SqlCommand("addNewMatch", conn);
            addM.CommandType = CommandType.StoredProcedure;
            addM.Parameters.Add(new SqlParameter("@host_name", hostName));
            addM.Parameters.Add(new SqlParameter("@guest_name", guestName));
            addM.Parameters.Add(new SqlParameter("@start_datetime", startTime));
            addM.Parameters.Add(new SqlParameter("@end_datetime", endTime));

            conn.Open();
            addM.ExecuteNonQuery();
            conn.Close();
        }
        protected void SAMMatchDelete_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string hostName = SAMHostNameDropList.SelectedValue;
            string guestName = SAMGuestNameDropList.SelectedValue;
            SqlCommand deleteM = new SqlCommand("deleteMatch", conn);
            deleteM.CommandType = CommandType.StoredProcedure;
            deleteM.Parameters.Add(new SqlParameter("@host_name", hostName));
            deleteM.Parameters.Add(new SqlParameter("@guest_name", guestName));
            conn.Open();
            deleteM.ExecuteNonQuery();
            conn.Close();
        }

        protected void Unnamed6_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }

}
