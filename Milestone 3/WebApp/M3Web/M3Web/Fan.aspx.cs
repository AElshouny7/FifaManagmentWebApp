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

namespace M3Web
{
    public partial class Fan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();
            SqlCommand getNationalID = new SqlCommand("SELECT national_id , status FROM Fan WHERE username ='" + Session["username"].ToString() + "'", conn);
            SqlDataReader rdrGetNationalID = getNationalID.ExecuteReader();
            if (rdrGetNationalID.Read())
                Session["nationalID"] = rdrGetNationalID.GetString(0);
            Session["status"] = (bool)rdrGetNationalID.GetBoolean(1);
        }

        public string getAvailableMatches()
        {
            string htmlStr = "";
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            conn.Open();
            SqlCommand matches = new SqlCommand("SELECT * FROM availableMatchesToAttend('" + DateTime.Parse(FanDateTextBox.Text) + "')", conn);
            SqlDataReader rdrMatches = matches.ExecuteReader();
            if (rdrMatches.Read())
            {
                string hostName = rdrMatches.GetString(0);
                string guestName = rdrMatches.GetString(1);
                string startsAt = rdrMatches.GetDateTime(2).ToString("dd/MM/yyyy hh:mm tt");
                string stadium = rdrMatches.GetString(3);
                string location = rdrMatches.GetString(4);

                htmlStr += "<tr><td>" + hostName + "</td><td>" + guestName + "</td><td>" + startsAt + "</td><td>" + stadium + "</td><td>" + location + "</td><td>";

                conn.Close();
                return htmlStr;
            }
            return htmlStr;


        }

        protected void Date_Click(object sender, EventArgs e)
        {
            FanAskForDateDiv.Visible = false;
            FanMatchesDiv.Visible = true;
        }

        protected void Purchase_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string nationalID = Session["nationalID"].ToString();
            string hostName = HostNameDropList.SelectedValue;
            string guestName = GuestNameDropList.SelectedValue;
            DateTime date = DateTime.Parse(StartTimeDropList.SelectedValue);

            SqlCommand sendReq = new SqlCommand("purchaseTicket", conn);
            sendReq.CommandType = CommandType.StoredProcedure;
            sendReq.Parameters.Add(new SqlParameter("@national_id", nationalID));
            sendReq.Parameters.Add(new SqlParameter("@host_name", hostName));
            sendReq.Parameters.Add(new SqlParameter("@guest_name", guestName));
            sendReq.Parameters.Add(new SqlParameter("@start_time", date));

            conn.Open();
            SqlCommand checker = new SqlCommand("SELECT * FROM allTickets WHERE hostClub = '" + hostName + "' AND guestClub = '" + guestName + "' AND startsAt ='" + date + "'", conn);
            SqlDataReader rdrChecker = checker.ExecuteReader();
            if (!rdrChecker.Read())
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('No Available Tickets for this Game!')", true);
            }
            else
            {
                sendReq.ExecuteNonQuery();
                conn.Close();
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Purchased Successfully!')", true);

            }

        }


    }
}