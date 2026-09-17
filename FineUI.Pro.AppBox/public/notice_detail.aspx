<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="notice_detail.aspx.cs" Inherits="FineUI.Pro.AppBox.Public.notice_detail" %>

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
                <f:Form ID="SimpleForm1" ShowBorder="true" ShowBorderShadow="true" ShowHeader="false" BodyPadding="10" AutoScroll="true" LabelWidth="80px" runat="server">
                    <Rows>
                        <f:FormRow ID="FormRow1" runat="server">
                            <Items>
                                <f:Label ID="labTitle" runat="server" Label="标题">
                                </f:Label>
                            </Items>
                        </f:FormRow>
                        <f:FormRow ID="FormRow2" runat="server">
                            <Items>
                                <f:Label ID="labDepartment" runat="server" Label="发布部门">
                                </f:Label>
                                <f:Label ID="labPublishTime" runat="server" Label="发布时间">
                                </f:Label>
                            </Items>
                        </f:FormRow>
                        <f:FormRow ID="FormRow3" runat="server">
                            <Items>
                                <f:Label ID="labContent" runat="server" Label="正文">
                                </f:Label>
                            </Items>
                        </f:FormRow>
                    </Rows>
                </f:Form>
            </Items>
        </f:Panel>
    </form>
</body>
</html>
