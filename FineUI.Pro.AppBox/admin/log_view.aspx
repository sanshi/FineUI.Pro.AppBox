<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="log_view.aspx.cs" Inherits="FineUI.Pro.AppBox.admin.log_view" %>

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
                    </Items>
                </f:Toolbar>
            </Toolbars>
            <Items>
                <f:SimpleForm ID="SimpleForm1" ShowBorder="true" ShowBorderShadow="true" ShowHeader="false" BodyPadding="10" AutoScroll="true" runat="server">
                    <Items>
                        <f:Label ID="labId" runat="server" Label="ID">
                        </f:Label>
                        <f:Label ID="labDateTime" runat="server" Label="时间">
                        </f:Label>
                        <f:Label ID="labLevel" runat="server" Label="级别">
                        </f:Label>
                        <f:Label ID="labSource" runat="server" Label="源">
                        </f:Label>
                        <f:Label ID="labMessage" runat="server" Label="错误信息">
                        </f:Label>
                        <f:Label ID="labException" runat="server" Label="异常消息">
                        </f:Label>
                    </Items>
                </f:SimpleForm>
            </Items>
        </f:Panel>
    </form>
</body>
</html>
