<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="user_view.aspx.cs" Inherits="FineUI.Pro.AppBox.admin.user_view" %>

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
                <f:Form ID="SimpleForm1" ShowBorder="true" ShowBorderShadow="true" ShowHeader="false" BodyPadding="10" AutoScroll="true" runat="server">
                    <Rows>
                        <f:FormRow runat="server">
                            <Items>
                                <f:Label ID="labName" runat="server" Label="用户名">
                                </f:Label>
                                <f:Label ID="labRealName" runat="server" Label="中文名">
                                </f:Label>
                            </Items>
                        </f:FormRow>
                        <f:FormRow runat="server">
                            <Items>
                                <f:Label ID="labGender" runat="server" Label="性别">
                                </f:Label>
                                <f:Label ID="labEnabled" runat="server" Label="是否启用">
                                </f:Label>
                            </Items>
                        </f:FormRow>
                        <f:FormRow runat="server">
                            <Items>
                                <f:Label ID="labEmail" runat="server" Label="个人邮箱">
                                </f:Label>
                                <f:Label ID="labCompanyEmail" runat="server" Label="公司邮箱">
                                </f:Label>
                            </Items>
                        </f:FormRow>
                        <f:FormRow runat="server">
                            <Items>
                                <f:Label ID="labOfficePhone" runat="server" Label="工作电话">
                                </f:Label>
                                <f:Label ID="labOfficePhoneExt" runat="server" Label="分机号">
                                </f:Label>
                            </Items>
                        </f:FormRow>
                        <f:FormRow runat="server">
                            <Items>
                                <f:Label ID="labHomePhone" runat="server" Label="家庭电话">
                                </f:Label>
                                <f:Label ID="labCellPhone" runat="server" Label="手机号">
                                </f:Label>
                            </Items>
                        </f:FormRow>
                        <f:FormRow runat="server">
                            <Items>
                                <f:Label ID="labRole" runat="server" Label="所属角色">
                                </f:Label>
                            </Items>
                        </f:FormRow>
                        <f:FormRow runat="server">
                            <Items>
                                <f:Label ID="labDept" runat="server" Label="所属部门">
                                </f:Label>
                            </Items>
                        </f:FormRow>
                        <f:FormRow runat="server">
                            <Items>
                                <f:Label ID="labTitle" runat="server" Label="拥有职称">
                                </f:Label>
                            </Items>
                        </f:FormRow>
                        <f:FormRow runat="server">
                            <Items>
                                <f:Label ID="labRemark" runat="server" Label="备注">
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
