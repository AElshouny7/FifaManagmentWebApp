<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sports_Association_Manager.aspx.cs" Inherits="M3Web.Sports_Association_Manager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center">
            <h1 style="text-align: center">Sports Association Manager
               
                <asp:Panel runat="server"></asp:Panel>
            </h1>
            <br />
            <br />
            <asp:RadioButtonList ID="Matches_Type" runat="server" AutoPostBack="True" Align="Center" RepeatDirection="Horizontal" OnSelectedIndexChanged="Matches_Type_SelectedIndexChanged">
                <asp:ListItem>All Matches</asp:ListItem>
                <asp:ListItem>All Upcoming Matches</asp:ListItem>
                <asp:ListItem>All Played Matches</asp:ListItem>
                <asp:ListItem>Never VS</asp:ListItem>
            </asp:RadioButtonList>
            <br />
        </div>

        <div runat="server" id="SAMAllMatches" visible="false">
            <h2 style="text-align: center">Matches</h2>
            <table width="50%" align="center" cellpadding="2" cellspacing="2" border="0" bgcolor="#EAEAEA">
                <tr align="left" style="background-color: #004080; color: White;">
                    <td>Host Club</td>
                    <td>Guest Club</td>
                    <td>Starts At</td>
                    <td>Ends At</td>
                </tr>

                <%=getMatchData()%>
            </table>
        </div>

        <div runat="server" id="SAMAllUpcomingMatches" visible="false">
            <h2 style="text-align: center">Upcoming Matches</h2>
            <table width="50%" align="center" cellpadding="2" cellspacing="2" border="0" bgcolor="#EAEAEA">
                <tr align="left" style="background-color: #004080; color: White;">
                    <td>Host Club</td>
                    <td>Guest Club</td>
                    <td>Starts At</td>
                    <td>Ends At</td>
                </tr>

                <%=getMatchDataWithDate(">")%>
            </table>
        </div>

        <div runat="server" id="SAMAllPlayedMatches" visible="false">
            <h2 style="text-align: center">Played Matches</h2>
            <table width="50%" align="center" cellpadding="2" cellspacing="2" border="0" bgcolor="#EAEAEA">
                <tr align="left" style="background-color: #004080; color: White;">
                    <td>Host Club</td>
                    <td>Guest Club</td>
                    <td>Starts At</td>
                    <td>Ends At</td>
                </tr>

                <%=getMatchDataWithDate("<")%>
            </table>
        </div>

        <div runat="server" id="SAMNeverVS" visible="false">
            <h2 style="text-align: center">Never VS</h2>
            <table width="50%" align="center" cellpadding="2" cellspacing="2" border="0" bgcolor="#EAEAEA">
                <tr align="left" style="background-color: #004080; color: White;">
                    <td>Club 1</td>
                    <td>Club 2</td>
                </tr>

                <%=getNeverVSData()%>
            </table>
        </div>

        <div runat="server">
                <h3 style="text-align: left">Add/Delete</h3>

            <asp:Label runat="server" Text="Host Club Name"></asp:Label>
            <br />
            
            <asp:DropDownList ID="SAMHostNameDropList" runat="server" AutoPostBack="True" DataTextField="name" DataValueField="name" DataSourceID="Clubs"></asp:DropDownList><asp:SqlDataSource runat="server" ID="Clubs" ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>" SelectCommand="SELECT [name] FROM [Club]"></asp:SqlDataSource><asp:SqlDataSource runat="server" ID="SqlDataSource1"></asp:SqlDataSource>
            <br />
            <br />
            <asp:Label runat="server" Text="Guest Club Name"></asp:Label>
            <br />
            <asp:DropDownList ID="SAMGuestNameDropList" runat="server" AutoPostBack="True" DataTextField="name" DataValueField="name" DataSourceID="Clubs"></asp:DropDownList>
            <br />
            <br />
            <asp:Label runat="server" Text="Starts At"></asp:Label>
            <br />
            <asp:TextBox ID="SAMStartTime" runat="server" type="datetime-local"></asp:TextBox>
            <br />
            <br />
            <asp:Label runat="server" Text="Ends At"></asp:Label>
            <br />
            <asp:TextBox ID="SAMEndTime" runat="server" type="datetime-local"></asp:TextBox>
            <br />
            <br />

            <asp:Button ID="SAMMatchAdd" runat="server" Text="Add" OnClick="SAMMatchAdd_Click" />
            <asp:Button ID="SAMMatchDelete" runat="server" Text="Delete" OnClick="SAMMatchDelete_Click" />

            </div>
    </form>
</body>
</html>
