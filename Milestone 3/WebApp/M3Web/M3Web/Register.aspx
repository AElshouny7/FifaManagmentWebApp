<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="M3Web.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center">
            <asp:Label ID="Label1" runat="server" Text="Register"></asp:Label>
        </div>
        Name:<br />
        <asp:TextBox ID="register_name_textbox" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:RadioButtonList ID="User_Selection" runat="server" AutoPostBack="True" OnSelectedIndexChanged="User_Selection_SelectedIndexChanged">
            <asp:ListItem>Sports Association Manager</asp:ListItem>
            <asp:ListItem >Club Representative</asp:ListItem>
            <asp:ListItem>Stadium Manager</asp:ListItem>
            <asp:ListItem>Fan</asp:ListItem>
        </asp:RadioButtonList>
        <br />
        <div runat="server" id="RegisterUsernameDiv" visible="false">
            Username:<br />
            <asp:TextBox ID="register_username_textbox" runat="server"></asp:TextBox>
        </div>

        <div runat="server" id="RegisterPasswordDiv" visible="false">
            <br />
            Password<br />
            <asp:TextBox ID="register_password_textbox" type="password" runat="server"></asp:TextBox>
        </div>

        <div runat="server" id="RegisterClubNameDiv" visible="false">
            <br />
            Club Name:<br />
            <asp:DropDownList ID="RegisterClubNameDropList" runat="server" DataTextField="name" DataValueField="name" DataSourceID="Clubs"></asp:DropDownList><asp:SqlDataSource runat="server" ID="Clubs" ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>" SelectCommand="SELECT [name] FROM [Club] WHERE ([crUsername] IS NULL)"></asp:SqlDataSource>
        </div>

        <div runat="server" id="RegisterStadiumNameDiv" visible="false">
            <br />
            Stadium Name:<br />
            <asp:DropDownList ID="RegisterStadiumNameDropList" runat="server" AutoPostBack="True" DataTextField="name" DataValueField="name" DataSourceID="StadiumsNew"></asp:DropDownList><asp:SqlDataSource runat="server" ID="StadiumsNew" ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>" SelectCommand="SELECT [name] FROM [Stadium] WHERE ([username] IS NULL)"></asp:SqlDataSource><asp:SqlDataSource runat="server" ID="Stadiums" ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>" SelectCommand="SELECT [name] FROM [Stadium] WHERE ([username] IS NULL)"></asp:SqlDataSource>
        </div>
        
        <div runat="server" id="RegisterFanDiv" visible="false">
            <br />
            National ID:<br />
            <asp:TextBox ID="register_nationalID" runat="server"></asp:TextBox>
            <br />
            <br />
            Phone Number:<br />
            <asp:TextBox ID="register_phone_number" runat="server"></asp:TextBox>
            <br />
            <br />
            Birth Date:<br />
            <asp:TextBox ID="register_birth_date" runat="server"  type="date" ></asp:TextBox>
            <br />
            <br />
            Address:<br />
            <asp:TextBox ID="register_address" runat="server"></asp:TextBox>
        </div>
        <br />
        <br />
        <asp:Button ID="register_button" runat="server" OnClick="Register_Click" Text="Register" />
    </form>
</body>
</html>
