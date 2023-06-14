<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fan.aspx.cs" Inherits="M3Web.Fan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center">
            <h1 style="text-align: center">Fan</h1>
            <br />
            <br />
        </div>

        <div runat="server" id="FanAskForDateDiv" style="text-align: center">
            <br />
            <h3 style="text-align: center">Enter Date</h3>
            <asp:TextBox ID="FanDateTextBox" runat="server" type="date"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Date_button" runat="server" OnClick="Date_Click" Text="Enter" />
        </div>

        <div runat="server" id="FanMatchesDiv" visible="false">
            <h2 style="text-align: center">Available Matches to Attend</h2>
            <table width="50%" align="center" cellpadding="2" cellspacing="2" border="0" bgcolor="#EAEAEA">
                <tr align="left" style="background-color: #004080; color: White;">
                    <td>Host Club</td>
                    <td>Guest Club</td>
                    <td>Stadium Name</td>
                    <td>Stadium Location</td>
                </tr>

                <%=getAvailableMatches()%>
            </table>
            <br />
            <br />
            <h2>Purchase a Ticket</h2>
            <asp:SqlDataSource runat="server" ID="allTickets" ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>" SelectCommand="SELECT DISTINCT * FROM [allTickets]"></asp:SqlDataSource>
            <br />
            <asp:Label runat="server" Text="Host Name"></asp:Label>
            <br />
            <asp:DropDownList ID="HostNameDropList" runat="server" DataTextField="hostClub" DataValueField="hostClub" DataSourceID="allTickets" AutoPostBack="True"></asp:DropDownList>
            <br />
            <asp:Label runat="server" Text="Guest Name"></asp:Label>
            <br />
            <asp:DropDownList ID="GuestNameDropList" runat="server" DataTextField="guestClub" DataValueField="guestClub" DataSourceID="allTickets"></asp:DropDownList>
            <br />
            <asp:Label runat="server" Text="Start Time"></asp:Label>
            <br />
            <asp:DropDownList ID="StartTimeDropList" runat="server" DataTextField="startsAt" DataValueField="startsAt" DataSourceID="allTickets"></asp:DropDownList>
            <br />
            <asp:Button ID="FanPurchaseButton" runat="server" OnClick="Purchase_Click" Text="Purchase" />

        </div>
    </form>
</body>
</html>
