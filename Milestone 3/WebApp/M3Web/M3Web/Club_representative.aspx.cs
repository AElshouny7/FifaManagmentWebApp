using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Controls.Primitives;
using System.Xml.Linq;
using System.Globalization;


namespace M3Web
{
    public partial class Club_representative : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            conn.Open();
            SqlCommand club = new SqlCommand("SELECT name FROM Club WHERE crUsername = '" + Session["username"].ToString() + "'", conn);
            SqlDataReader rdrClub = club.ExecuteReader();
            if (rdrClub.Read())
            {
                string name = rdrClub.GetString(0);
                Session["club_name"] = name;
            }

            conn.Close();
        }

        protected void CR_Selection_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (CR_Selection.SelectedIndex)
            {
                case 0:
                    CRClubDiv.Visible = true;
                    CRUpcomingDiv.Visible = false;
                    CRAskForDateDiv.Visible = false;
                    CRSendRequestDiv.Visible = false;
                    CRStadiumsDiv.Visible = false;
                    break;
                case 1:
                    CRClubDiv.Visible = false;
                    CRUpcomingDiv.Visible = true;
                    CRAskForDateDiv.Visible = false;
                    CRSendRequestDiv.Visible = false;
                    CRStadiumsDiv.Visible = false;
                    break;
                case 2:
                    CRClubDiv.Visible = false;
                    CRUpcomingDiv.Visible = false;
                    CRAskForDateDiv.Visible = true;
                    CRSendRequestDiv.Visible = false;
                    CRStadiumsDiv.Visible = false;
                    break;
                case 3:
                    CRClubDiv.Visible = false;
                    CRUpcomingDiv.Visible = false;
                    CRAskForDateDiv.Visible = false;
                    CRSendRequestDiv.Visible = true;
                    CRStadiumsDiv.Visible = false;
                    break;
                default:
                    CRClubDiv.Visible = false;
                    CRUpcomingDiv.Visible = false;
                    CRAskForDateDiv.Visible = false;
                    CRSendRequestDiv.Visible = false;
                    CRStadiumsDiv.Visible = false;
                    break;
            }
        }

        public string getMyClubData()
        {
            string htmlStr = "";
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            conn.Open();
            SqlCommand club = new SqlCommand("SELECT * FROM Club WHERE crUsername = '" + Session["username"].ToString() + "'", conn);
            SqlDataReader rdrClub = club.ExecuteReader();
            if (rdrClub.Read())
            {
                string name = Session["club_name"].ToString();
                int id = rdrClub.GetInt32(1);
                string location = rdrClub.GetString(2);
                htmlStr += "<tr><td>" + id + "</td><td>" + name + "</td><td>" + location + "</td><td>";

                conn.Close();
                return htmlStr;
            }
            return htmlStr;


        }

        public string getUpcomingMatchesData()
        {
            string htmlStr = "";
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            conn.Open();
            SqlCommand upcomingMatches = new SqlCommand("SELECT * FROM upcomingMatchesOfClub('" + Session["club_name"] + "')", conn);
            SqlDataReader rdrupcomingMatches = upcomingMatches.ExecuteReader();
            if (rdrupcomingMatches.Read())
            {
                string hostClubName = rdrupcomingMatches.GetString(0);
                string guestClubName = rdrupcomingMatches.GetString(1);
                DateTime startTime = rdrupcomingMatches.GetDateTime(2);
                DateTime endTime = rdrupcomingMatches.GetDateTime(3);
                string stadium = "";
                try
                {
                    stadium = rdrupcomingMatches.GetString(4);
                }
                catch (Exception)
                { 
                    stadium = "";
                }

                htmlStr += "<tr><td>" + hostClubName + "</td><td>" + guestClubName + "</td><td>" + startTime + "</td><td>" + endTime + "</td><td>" + stadium + "</td><td>";

                conn.Close();
                return htmlStr;
            }
            return htmlStr;


        }

        protected void Button_Click(object sender, EventArgs e)
        {
            CRAskForDateDiv.Visible = false;
            CRStadiumsDiv.Visible = true;
        }

        public string getAvailableStadiumsData()
        {
            string htmlStr = "";
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            conn.Open();
            SqlCommand availableStadiums = new SqlCommand("SELECT * FROM viewAvailableStadiumsOn('" + DateTime.Parse(CRDateTextBox.Text) + "')", conn);
            SqlDataReader rdrAvailableStadiums = availableStadiums.ExecuteReader();
            if (rdrAvailableStadiums.Read())
            {
                string name = rdrAvailableStadiums.GetString(0);
                string location = rdrAvailableStadiums.GetString(1);
                int capacity = rdrAvailableStadiums.GetInt32(2);
                string availableOn = rdrAvailableStadiums.GetDateTime(3).ToString("dd/MM/yyyy hh:mm tt");

                htmlStr += "<tr><td>" + name + "</td><td>" + location + "</td><td>" + capacity + "</td><td>" + availableOn + "</td><td>";

                conn.Close();

            }
            return htmlStr;


        }

        protected void CRSendRequest_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string clubName = Session["club_name"].ToString();
            DateTime date = DateTime.Parse(CRSendRequestDateTextBox.Text);
            string stadiumName = CRStadiumNamesDropList.SelectedValue;

            SqlCommand sendReq = new SqlCommand("addHostRequest", conn);
            sendReq.CommandType = CommandType.StoredProcedure;
            sendReq.Parameters.Add(new SqlParameter("@club_name", clubName));
            sendReq.Parameters.Add(new SqlParameter("@stadium_name", stadiumName));
            sendReq.Parameters.Add(new SqlParameter("@datetime", date));

            conn.Open();
            SqlCommand checkerHasMatch = new SqlCommand("SELECT * FROM Club C, Match M WHERE C.id = M.plays_as_hostid AND C.crUsername = '" + Session["username"] + "'", conn);
            SqlDataReader rdrCheckerHasMatch = checkerHasMatch.ExecuteReader();

            if (rdrCheckerHasMatch.Read())
            {
                sendReq.ExecuteNonQuery();
                conn.Close();
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Sent Successfully!')", true);
                
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Your Team Doesn't have an Upcoming Match!')", true);
            }
        }

    }
}