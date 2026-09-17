<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="FineUI.Pro.AppBox.admin._default" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title></title>
    <style type="text/css">
        
    </style>
</head>
<body class="f-body-darkerbg">
    <form id="form1" runat="server">
        <f:PageManager ID="PageManager1" runat="server" />
        <f:Panel ID="Panel1" Layout="HBox" BoxConfigChildMargin="0 10 0 0" ShowBorder="false" ShowHeader="false" IsFluid="true" Margin="20px" runat="server">
            <Items>
                <f:Panel BoxFlex="1" ShowBorder="false" ShowHeader="false" runat="server">
                    <Items>
                        <f:Panel ID="Panel2" Title="系统公告" Height="200px" runat="server" MarginBottom="10px" BodyPadding="10px" ShowBorder="true" ShowBorderShadow="true" ShowHeader="true">
                            <Items>
                                <f:Label ID="Label1" runat="server" Text="这是系统公告"></f:Label>
                            </Items>
                        </f:Panel>
                        <f:Panel ID="Panel4" Title="系统公告" Height="200px" runat="server" MarginBottom="10px" BodyPadding="10px" ShowBorder="true" ShowBorderShadow="true" ShowHeader="true">
                            <Items>
                                <f:Label ID="Label3" runat="server" Text="这是系统公告"></f:Label>
                            </Items>
                        </f:Panel>
                    </Items>
                </f:Panel>
                <f:Panel BoxFlex="1" Margin="0" ShowBorder="false" ShowHeader="false" runat="server">
                    <Items>
                        <f:Panel ID="Panel3" Title="代办事宜" Height="200px" runat="server" MarginBottom="10px" BodyPadding="10px" ShowBorder="true" ShowBorderShadow="true" ShowHeader="true">
                            <Items>
                                <f:Label ID="Label2" runat="server" Text="这是代办事宜列表"></f:Label>
                            </Items>
                        </f:Panel>
                        <f:Panel ID="Panel6" Title="注意事项" Height="200px" runat="server" MarginBottom="10px" BodyPadding="10px" ShowBorder="true" ShowBorderShadow="true" ShowHeader="true">
                            <Items>
                                <f:Label ID="Label4" runat="server" Text="这是注意事项列表"></f:Label>
                            </Items>
                        </f:Panel>
                    </Items>
                </f:Panel>
            </Items>
        </f:Panel>
    </form>
</body>
</html>
