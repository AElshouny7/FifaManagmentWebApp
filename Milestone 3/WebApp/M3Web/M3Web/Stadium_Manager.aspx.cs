using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3Web
{
    public partial class Stadium_Manager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PendingLast.SelectCommand = "SELECT crNameP AS Expr1, hostClubNameP AS Expr2, guestClubNameP AS Expr3 , startTimeP AS Expr4 , endTimeP AS Expr5 , status AS Expr6   FROM dbo.allPendingRequests('" + Session["username"] + "') AS allPendingRequests_1";
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            conn.Open();
            SqlCommand stadium = new SqlCommand("SELECT name FROM Stadium WHERE username = '" + Session["username"].ToString() + "'", conn);
            SqlDataReader rdrStadium = stadium.ExecuteReader();
            if (rdrStadium.Read())
            {
                string name = rdrStadium.GetString(0);
                Session["stadium_name"] = name;
            }
            conn.Close();

        }

        protected void SM_Selection_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (SM_Selection.SelectedIndex)
            {
                case 0:
                    SMStadiumDiv.Visible = true;
                    SMReceivedRequests.Visible = false;
                    break;
                case 1:
                    SMStadiumDiv.Visible = false;
                    SMReceivedRequests.Visible = true;
                    break;
                case 2:
                    SMStadiumDiv.Visible = false;
                    SMReceivedRequests.Visible = false;
                    break;
                default:
                    SMStadiumDiv.Visible = false;
                    SMReceivedRequests.Visible = false;
                    break;
            }
        }

        public string getMyStadiumData()
        {
            string htmlStr = "";
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            conn.Open();
            SqlCommand stadium = new SqlCommand("SELECT id , name , capacity , location , status FROM Stadium WHERE username = '" + Session["username"].ToString() + "'", conn);
            SqlDataReader rdrStadium = stadium.ExecuteReader();
            if (rdrStadium.Read())
            {
                int id = rdrStadium.GetInt32(0);
                string name = rdrStadium.GetString(1);
                int capacity = rdrStadium.GetInt32(2);
                string location = rdrStadium.GetString(3);
                string status = (bool)rdrStadium.GetBoolean(4) ? "Available" : "Unavailable";

                htmlStr += "<tr><td>" + id + "</td><td>" + name + "</td><td>" + capacity + "</td><td>" + location + "</td><td>" + status + "</td><td>";

                conn.Close();
                return htmlStr;
            }
            return htmlStr;


        }

        public string getMyReceivedRequestsData()
        {
            string htmlStr = "";
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            conn.Open();
            SqlCommand req = new SqlCommand("SELECT * FROM RequestsFromAll('" + Session["username"].ToString() + "')", conn);
            SqlDataReader rdrReq = req.ExecuteReader();
            if (rdrReq.Read())
            {
                string crName = rdrReq.GetString(0);
                string hostName = rdrReq.GetString(1);
                string guestName = rdrReq.GetString(2);
                DateTime startTime = rdrReq.GetDateTime(3);
                DateTime endTime = rdrReq.GetDateTime(4);
                string status = rdrReq.GetString(5);

                htmlStr += "<tr><td>" + crName + "</td><td>" + hostName + "</td><td>" + guestName + "</td><td>" + startTime + "</td><td>" + endTime + "</td><td>" + status + "</td><td>";

                conn.Close();
                return htmlStr;
            }
            return htmlStr;


        }


        public string getSMUsername()
        {
            return Session["username"].ToString();
        }

        protected void SMAccept_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string hostClub = SMHostClubDropList.SelectedValue;
            string guestClub = SMGuestClubDropList.SelectedValue;
            DateTime startsAt = DateTime.Parse(SMStartsAtDropList.SelectedValue);

            SqlCommand acceptR = new SqlCommand("acceptRequest", conn);
            acceptR.CommandType = CommandType.StoredProcedure;
            acceptR.Parameters.Add(new SqlParameter("@sm_username", Session["username"].ToString()));
            acceptR.Parameters.Add(new SqlParameter("@host_name", hostClub));
            acceptR.Parameters.Add(new SqlParameter("@guest_name", guestClub));
            acceptR.Parameters.Add(new SqlParameter("@start_time", startsAt));

            conn.Open();
            acceptR.ExecuteNonQuery();
            conn.Close();

            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Request Accepted!')", true);

        }
        protected void SMReject_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string hostClub = SMHostClubDropList.SelectedValue;
            string guestClub = SMGuestClubDropList.SelectedValue;
            DateTime startsAt = DateTime.Parse(SMStartsAtDropList.SelectedValue);

            SqlCommand rejectR = new SqlCommand("rejectRequest", conn);
            rejectR.CommandType = CommandType.StoredProcedure;
            rejectR.Parameters.Add(new SqlParameter("@sm_username", Session["username"].ToString()));
            rejectR.Parameters.Add(new SqlParameter("@host_name", hostClub));
            rejectR.Parameters.Add(new SqlParameter("@guest_name", guestClub));
            rejectR.Parameters.Add(new SqlParameter("@start_time", startsAt));

            conn.Open();
            rejectR.ExecuteNonQuery();
            conn.Close();

            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Request Rejected!')", true);
        }

    }
}