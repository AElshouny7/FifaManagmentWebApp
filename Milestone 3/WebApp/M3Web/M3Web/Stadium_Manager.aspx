<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Stadium_Manager.aspx.cs" Inherits="M3Web.Stadium_Manager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center">
            <h1 style="text-align: center">Stadium Manager
                <asp:Panel runat="server"></asp:Panel>
            </h1>
            <br />
            <br />
            <asp:RadioButtonList ID="SM_Selection" runat="server" AutoPostBack="True" OnSelectedIndexChanged="SM_Selection_SelectedIndexChanged" Align="Center" RepeatDirection="Horizontal">
                <asp:ListItem>My Stadium Information</asp:ListItem>
                <asp:ListItem>Received Requests</asp:ListItem>
            </asp:RadioButtonList>
            <br />
        </div>

        <div runat="server" id="SMStadiumDiv" visible="false">
            <h2 style="text-align: center">My Stadium Information</h2>
            <table width="50%" align="center" cellpadding="2" cellspacing="2" border="0" bgcolor="#EAEAEA">
                <tr align="left" style="background-color: #004080; color: White;">
                    <td>id</td>
                    <td>Name</td>
                    <td>Capacity</td>
                    <td>Location</td>
                    <td>Status</td>
                </tr>

                <%=getMyStadiumData()%>
            </table>
        </div>

        <div runat="server" id="SMReceivedRequests" visible="false">
            <h2 style="text-align: center">Received Requests</h2>
            <table width="50%" align="center" cellpadding="2" cellspacing="2" border="0" bgcolor="#EAEAEA">
                <tr align="left" style="background-color: #004080; color: White;">
                    <td>Club Representative</td>
                    <td>Host Club</td>
                    <td>Guest Club</td>
                    <td>Starts at</td>
                    <td>Ends at</td>
                    <td>Status</td>
                </tr>

                <%=getMyReceivedRequestsData()%>
            </table>

            
            <asp:Label runat="server" Text="Accept/Reject"></asp:Label>
            <br />
            <br />
            <asp:SqlDataSource runat="server" ID="PendingLast" ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>"></asp:SqlDataSource>
            <br />
            <asp:Label runat="server" Text="Host Club"></asp:Label>
            <asp:DropDownList ID="SMHostClubDropList" runat="server" AutoPostBack="True" DataTextField="Expr2" DataValueField="Expr2" DataSourceID="PendingLast"></asp:DropDownList>
            <br />
            <asp:Label runat="server" Text="Guest Club"></asp:Label>
            <asp:DropDownList ID="SMGuestClubDropList" runat="server" AutoPostBack="True" DataTextField="Expr3" DataValueField="Expr3" DataSourceID="PendingLast"></asp:DropDownList>
            <br />
            <asp:Label runat="server" Text="Starts At"></asp:Label>
            <asp:DropDownList ID="SMStartsAtDropList" runat="server" AutoPostBack="True" DataTextField="Expr4" DataValueField="Expr4" DataSourceID="PendingLast"></asp:DropDownList>
            <br />
            <br />
            <asp:Button ID="SMAccept" runat="server" Text="Accept" OnClick="SMAccept_Click" />
            <asp:Button ID="SMReject" runat="server" Text="Reject" OnClick="SMReject_Click" />

        </div>
    </form>
</body>
</html>
