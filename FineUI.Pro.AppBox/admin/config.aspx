<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="config.aspx.cs" Inherits="FineUI.Pro.AppBox.admin.config" %>

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
                <f:SimpleForm ID="SimpleForm1" runat="server" LabelWidth="120px" Width="600px" LabelAlign="Top" ShowBorder="false" ShowHeader="false">
                    <Items>
                        <f:DropDownList ID="ddlPageSize" Label="表格默认记录数" Required="true" ShowRedStar="true" runat="server">
                            <Items>
                                <f:ListItem Text="10" Value="10" />
                                <f:ListItem Text="20" Value="20" />
                                <f:ListItem Text="50" Value="50" />
                                <f:ListItem Text="100" Value="100" />
                            </Items>
                        </f:DropDownList>
                        <f:TextArea runat="server" ID="tbxHelpList" Height="450" Label="帮助下拉列表" Required="true"
                            ShowRedStar="true">
                        </f:TextArea>
                        <f:Button ID="btnSave" runat="server" Icon="SystemSave" OnClick="btnSave_OnClick"
                            ValidateForms="SimpleForm1" ValidateTarget="Top" Text="保存设置">
                        </f:Button>
                    </Items>
                </f:SimpleForm>
            </Items>
        </f:Panel>
    </form>
</body>
</html>
