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
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Register_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string name = register_name_textbox.Text;
            string username = register_username_textbox.Text;
            string password = register_password_textbox.Text;
            conn.Open();

            if (name == "" || username == "" || password == "")
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Enter Credentials!')", true);
            else
            {
                SqlCommand checker = new SqlCommand("SELECT username FROM SystemUser WHERE username = '" + username + "'", conn);
                SqlDataReader rdrChecker = checker.ExecuteReader();
                if (rdrChecker.Read())
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('User Already Registered!')", true);
                }
                else
                {
                    if (User_Selection.SelectedIndex == 0) // Sports Association Manager
                    {
                        SqlCommand addSAM = new SqlCommand("addAssociationManager", conn);
                        addSAM.CommandType = CommandType.StoredProcedure;
                        addSAM.Parameters.Add(new SqlParameter("@name", name));
                        addSAM.Parameters.Add(new SqlParameter("@username", username));
                        addSAM.Parameters.Add(new SqlParameter("@password", password));



                        addSAM.ExecuteNonQuery();
                        conn.Close();
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Registered!')", true);
                        Response.Redirect("~/Login.aspx");


                    }

                    else if (User_Selection.SelectedIndex == 1) // Club Representative
                    {
                        string clubName = RegisterClubNameDropList.SelectedValue;

                        SqlCommand addCR = new SqlCommand("addRepresentative", conn);
                        addCR.CommandType = CommandType.StoredProcedure;
                        addCR.Parameters.Add(new SqlParameter("@name", name));
                        addCR.Parameters.Add(new SqlParameter("@username", username));
                        addCR.Parameters.Add(new SqlParameter("@password", password));
                        addCR.Parameters.Add(new SqlParameter("@club_name", clubName));

                        if (clubName == "")
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Enter Credentials!')", true);
                        else
                        {
                            addCR.ExecuteNonQuery();
                            conn.Close();
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Registered!')", true);
                            Response.Redirect("~/Login.aspx");
                        }

                    }
                    else if (User_Selection.SelectedIndex == 2) // Stadium Manager
                    {
                        string StadiumName = RegisterStadiumNameDropList.SelectedValue;

                        SqlCommand addSM = new SqlCommand("addStadiumManager", conn);
                        addSM.CommandType = CommandType.StoredProcedure;
                        addSM.Parameters.Add(new SqlParameter("@name", name));
                        addSM.Parameters.Add(new SqlParameter("@username", username));
                        addSM.Parameters.Add(new SqlParameter("@password", password));
                        addSM.Parameters.Add(new SqlParameter("@stadium_name", StadiumName));

                        if (StadiumName == "")
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Enter Credentials!')", true);
                        else
                        {
                            addSM.ExecuteNonQuery();
                            conn.Close();
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Registered!')", true);
                            Response.Redirect("~/Login.aspx");
                        }

                    }

                    else if (User_Selection.SelectedIndex == 3) // Fan
                    {
                        string nationalID = register_nationalID.Text;
                        DateTime birthDate = DateTime.Parse(register_birth_date.Text);
                        string phoneNumber = register_phone_number.Text;
                        string address = register_address.Text;

                        SqlCommand addF = new SqlCommand("addFan", conn);
                        addF.CommandType = CommandType.StoredProcedure;
                        addF.Parameters.Add(new SqlParameter("@username", username));
                        addF.Parameters.Add(new SqlParameter("@password", password));
                        addF.Parameters.Add(new SqlParameter("@name", name));
                        addF.Parameters.Add(new SqlParameter("@national_id_number", nationalID));
                        addF.Parameters.Add(new SqlParameter("@birth_date", birthDate));
                        addF.Parameters.Add(new SqlParameter("@phone_number", phoneNumber));
                        addF.Parameters.Add(new SqlParameter("@address", address));

                        if (nationalID == "" || birthDate == null || phoneNumber == "" || address == "")
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Enter Credentials!')", true);
                        else
                        {
                            addF.ExecuteNonQuery();
                            conn.Close();

                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Registered!')", true);
                            Response.Redirect("~/Login.aspx");
                        }


                    }
                }




            }
        }

        protected void User_Selection_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (User_Selection.SelectedIndex)
            {
                case 0:
                    RegisterUsernameDiv.Visible = true;
                    RegisterPasswordDiv.Visible = true;
                    RegisterClubNameDiv.Visible = false;
                    RegisterStadiumNameDiv.Visible = false;
                    RegisterFanDiv.Visible = false;
                    break;
                case 1:
                    RegisterUsernameDiv.Visible = true;
                    RegisterPasswordDiv.Visible = true;
                    RegisterClubNameDiv.Visible = true;
                    RegisterStadiumNameDiv.Visible = false;
                    RegisterFanDiv.Visible = false;
                    break;
                case 2:
                    RegisterUsernameDiv.Visible = true;
                    RegisterPasswordDiv.Visible = true;
                    RegisterStadiumNameDiv.Visible = true;
                    RegisterClubNameDiv.Visible = false;
                    RegisterFanDiv.Visible = false;
                    break;
                case 3:
                    RegisterFanDiv.Visible = true;
                    RegisterUsernameDiv.Visible = true;
                    RegisterPasswordDiv.Visible = true;
                    RegisterClubNameDiv.Visible = false;
                    RegisterStadiumNameDiv.Visible = false;
                    break;

                default:
                    RegisterUsernameDiv.Visible = false;
                    RegisterPasswordDiv.Visible = false;
                    RegisterClubNameDiv.Visible = false;
                    RegisterStadiumNameDiv.Visible = false;
                    RegisterFanDiv.Visible = false;
                    break;
            }



        }


    }
}