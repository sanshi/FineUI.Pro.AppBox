<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="changepassword.aspx.cs" Inherits="FineUI.Pro.AppBox.admin.changepassword" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title></title>
</head>
<body class="f-body-darkerbg">
    <form id="form1" runat="server">
        <f:PageManager ID="PageManager1" runat="server" />
        <f:Panel ID="Panel1" ShowHeader="false" ShowBorder="true" ShowBorderShadow="true"
            BodyPadding="10px" AutoScroll="true" IsFluid="true" Margin="20px" runat="server">
            <Items>
                <f:SimpleForm ID="SimpleForm1" runat="server" LabelWidth="100px" Width="600px"
                    LabelAlign="Top" ShowBorder="false" ShowHeader="false">
                    <Items>
                        <f:TextBox ID="tbxOldPassword" TextMode="Password" runat="server" Label="当前密码" Required="true"
                            ShowRedStar="true">
                        </f:TextBox>
                        <f:TextBox ID="tbxNewPassword" TextMode="Password" runat="server" Label="新密码" Required="true"
                            MinLength="6" ShowRedStar="true">
                        </f:TextBox>
                        <f:TextBox ID="tbxConfirmNewPassword" TextMode="Password" runat="server" Label="确认新密码"
                            Required="true" ShowRedStar="true">
                        </f:TextBox>
                        <f:Button ID="btnSave" runat="server" Icon="SystemSave" OnClick="btnSave_OnClick"
                            ValidateForms="SimpleForm1" ValidateTarget="Top" Text="修改密码">
                        </f:Button>
                    </Items>
                </f:SimpleForm>
            </Items>
        </f:Panel>
    </form>
</body>
</html>
