<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="System_Admin.aspx.cs" Inherits="M3Web.System_Admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center">
            <h1 style="text-align: center"> System Admin <asp:Panel runat="server"></asp:Panel></h1>
            <br />
            <br />
            <asp:RadioButtonList ID="Panel_Selection" runat="server" AutoPostBack="True" OnSelectedIndexChanged="Panel_Selection_SelectedIndexChanged" Align="Center" RepeatDirection="Horizontal">
                <asp:ListItem>Clubs</asp:ListItem>
                <asp:ListItem>Stadiums</asp:ListItem>
                <asp:ListItem>Fans</asp:ListItem>
            </asp:RadioButtonList>
            <br />
        </div>
        <div runat="server" id="SystemAdminClub" visible="false">
            <h2 style="text-align: center">Clubs</h2>
            <table width="50%" align="center" cellpadding="2" cellspacing="2" border="0" bgcolor="#EAEAEA">
                <tr align="left" style="background-color: #004080; color: White;">
                    <td>Name</td>
                    <td>Location</td>
                </tr>

                <%=getClubsData()%>
            </table>
            <h3 style="text-align: left">Add/Delete</h3>

            <asp:Label ID="Label1" runat="server" Text="Name"></asp:Label> 
            <br />
            <asp:TextBox ID="SystemAdminClubName" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="Location"></asp:Label> 
            <br />
            <asp:TextBox ID="SystemAdminClubLocation" runat="server"></asp:TextBox>
            <br />
            <br />

            <asp:Button ID="SystemAdminClubAdd" runat="server" Text="Add" OnClick="SystemAdminClubAdd_Click" />
            <asp:Button ID="SystemAdminClubDelete" runat="server" Text="Delete" OnClick="SystemAdminClubDelete_Click" />

        </div>

        <div runat="server" id="SystemAdminStadiums" visible="false">

            <h2 style="text-align: center">Stadiums</h2>
            <table width="50%" align="center" cellpadding="2" cellspacing="2" border="0" bgcolor="#EAEAEA">
                <tr align="left" style="background-color: #004080; color: White;">
                    <td>Name</td>
                    <td>Location</td>
                </tr>

                <%=getStadiumData()%>
            </table>

            <asp:Label ID="Label3" runat="server" Text="Name"></asp:Label> 
            <br />
            <asp:TextBox ID="SystemAdminStadiumName" runat="server" ></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label4" runat="server" Text="Location"></asp:Label> 
            <br />
            <asp:TextBox ID="SystemAdminStadiumLocation" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label5" runat="server" Text="Capacity"></asp:Label> 
            <br />
            <asp:TextBox ID="SystemAdminStadiumCapacity" runat="server"></asp:TextBox>
            <br />
            <br />

            <asp:Button ID="SystemAdminStadiumAdd" runat="server" Text="Add" OnClick="SystemAdminStadiumAdd_Click" />
            <asp:Button ID="SystemAdminStadiumDelete" runat="server" Text="Delete" OnClick="SystemAdminStadiumDelete_Click" />

        </div>

        <div runat="server" id="SystemAdminFans" visible="false">
            <h2 style="text-align: center">Fan</h2>
            <table width="50%" align="center" cellpadding="2" cellspacing="2" border="0" bgcolor="#EAEAEA">
                <tr align="left" style="background-color: #004080; color: White;">
                    <td>Username</td>
                    <td>Password</td>
                    <td>Name</td>
                    <td>National ID</td>
                    <td>Birth Date</td>
                    <td>Status</td>
                </tr>


                 <%=getFanData()%>
            </table>

            
            <asp:Label runat="server" Text="National ID"></asp:Label> 
            <br />
            <asp:DropDownList ID="SystemAdminFanNationalIDDropList" runat="server" AutoPostBack="True" DataTextField="national_id" DataValueField="national_id" DataSourceID="Fans"></asp:DropDownList><asp:SqlDataSource runat="server" ID="Fans" ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>" SelectCommand="SELECT [national_id] FROM [Fan]"></asp:SqlDataSource>
            <br />
            <br />
            
            <asp:Button ID="SystemAdminFanBlock" runat="server" Text="Block" OnClick="SystemAdminFanBlock_Click" />
            <asp:Button ID="SystemAdminFanUnblock" runat="server" Text="Unblock" OnClick="SystemAdminFanUnblock_Click" />

        </div>


    </form>
</body>
</html>
