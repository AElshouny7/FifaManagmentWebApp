<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="M3Web.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center"></div>
        Username:<br />
        <asp:TextBox ID="login_username_textbox" runat="server"></asp:TextBox>
        <br />
        <br />
        Password:<br />
        <asp:TextBox ID="login_password_textbox" runat="server" type="Password"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Login_Button" runat="server" OnClick="Login_Click" Text="Login" />
        <br />
        <br />
        <asp:HyperLink runat="server" NavigateUrl="Register.aspx" >I don't have an Account</asp:HyperLink>
    </form>
</body>
</html>
