<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Club_representative.aspx.cs" Inherits="M3Web.Club_representative" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center">
            <h1 style="text-align: center">Club Representative
                <asp:Panel runat="server"></asp:Panel>
            </h1>
            <br />
            <br />
            <asp:RadioButtonList ID="CR_Selection" runat="server" AutoPostBack="True" OnSelectedIndexChanged="CR_Selection_SelectedIndexChanged" Align="Center" RepeatDirection="Horizontal">
                <asp:ListItem>My Club Information</asp:ListItem>
                <asp:ListItem>Upcoming Matches</asp:ListItem>
                <asp:ListItem>Available Stadiums</asp:ListItem>
                <asp:ListItem>Send Request</asp:ListItem>
            </asp:RadioButtonList>
            <br />
        </div>

        <div runat="server" id="CRClubDiv" visible="false">
            <h2 style="text-align: center">My Club Information</h2>
            <table width="50%" align="center" cellpadding="2" cellspacing="2" border="0" bgcolor="#EAEAEA">
                <tr align="left" style="background-color: #004080; color: White;">
                    <td>id</td>
                    <td>Name</td>
                    <td>Location</td>
                </tr>

                <%=getMyClubData()%>
            </table>
        </div>

        <div runat="server" id="CRUpcomingDiv" visible="false">
            <h2 style="text-align: center">Upcoming Matches</h2>
            <table width="50%" align="center" cellpadding="2" cellspacing="2" border="0" bgcolor="#EAEAEA">
                <tr align="left" style="background-color: #004080; color: White;">
                    <td>Host Club Name</td>
                    <td>Guest Club Name</td>
                    <td>Starts at</td>
                    <td>Ends at</td>
                    <td>Stadium Name</td>
                </tr>

                <%=getUpcomingMatchesData()%>
            </table>
        </div>

        <div runat="server" id="CRAskForDateDiv" style="text-align: center" visible="false">
            <br />
            <h3 style="text-align: center">Enter Date</h3>
            <asp:TextBox ID="CRDateTextBox" runat="server"  type="date"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Date_button" runat="server" OnClick="Button_Click" Text="Enter" />
        </div>

        <div runat="server" id="CRStadiumsDiv" visible="false">
            <h2 style="text-align: center">Available Stadiums</h2>
            <table width="50%" align="center" cellpadding="2" cellspacing="2" border="0" bgcolor="#EAEAEA">
                <tr align="left" style="background-color: #004080; color: White;">
                    <td>Name</td>
                    <td>Location</td>
                    <td>Capacity</td>
                    <td>Available On</td>
                </tr>

                <%=getAvailableStadiumsData()%>
            </table>
        </div>

        <div runat="server" id="CRSendRequestDiv" style="text-align: center" visible="false">
            <br />
            <h2 style="text-align: center">Send Request</h2>
            <br />
            <asp:Label runat="server" Text="Stadium Name"></asp:Label>
            <br />
            <asp:DropDownList ID="CRStadiumNamesDropList" runat="server" AutoPostBack="True" DataTextField="name" DataValueField="name" DataSourceID="Stadiums"></asp:DropDownList><asp:SqlDataSource runat="server" ID="Stadiums" ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>" SelectCommand="SELECT [name] FROM [Stadium]"></asp:SqlDataSource><asp:SqlDataSource runat="server" ID="Clubs" ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>" SelectCommand="SELECT [name] FROM [Club]"></asp:SqlDataSource>
            <br />
            <br />
            <asp:Label runat="server" Text="date"></asp:Label>
            <br />
            <asp:TextBox ID="CRSendRequestDateTextBox" runat="server" type="datetime-local"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="CRSendRequestButton" runat="server" OnClick="CRSendRequest_Click" Text="Send" />
        </div>
    </form>
</body>
</html>
