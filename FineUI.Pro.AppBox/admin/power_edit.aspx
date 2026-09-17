<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="power_edit.aspx.cs" Inherits="FineUI.Pro.AppBox.admin.power_edit" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title></title>
</head>
<body class="f-body-darkerbg">
    <form id="form1" runat="server">
        <f:PageManager ID="PageManager1" runat="server" />
        <f:Panel ID="Panel1" ShowBorder="false" ShowHeader="false" IsViewPort="true" BodyPadding="10" Layout="Fit" runat="server">
            <Toolbars>
                <f:Toolbar ID="Toolbar1" runat="server">
                    <Items>
                        <f:Button ID="btnClose" Icon="SystemClose" runat="server" ClickHandler="onCloseActiveWindowClick" Text="关闭">
                        </f:Button>
                        <f:ToolbarSeparator runat="server"></f:ToolbarSeparator>
                        <f:Button ID="btnSaveClose" ValidateForms="SimpleForm1" Icon="SystemSaveClose"
                            OnClick="btnSaveClose_Click" runat="server" Text="保存后关闭">
                        </f:Button>
                    </Items>
                </f:Toolbar>
            </Toolbars>
            <Items>
                <f:SimpleForm ID="SimpleForm1" ShowBorder="true" ShowBorderShadow="true" ShowHeader="false" BodyPadding="10" AutoScroll="true" runat="server">
                    <Items>
                        <f:TextBox ID="tbxGroupName" runat="server" Label="分组名称" Required="true" ShowRedStar="true">
                        </f:TextBox>
                        <f:TextBox ID="tbxName" runat="server" Label="名称" Required="true" ShowRedStar="true">
                        </f:TextBox>
                        <f:TextBox ID="tbxTitle" runat="server" Label="标题" Required="true" ShowRedStar="true">
                        </f:TextBox>
                        <f:TextArea ID="tbxRemark" runat="server" Label="备注">
                        </f:TextArea>
                    </Items>
                </f:SimpleForm>
            </Items>
        </f:Panel>
    </form>
</body>
</html>
