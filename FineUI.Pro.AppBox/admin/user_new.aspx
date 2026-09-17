<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="user_new.aspx.cs" Inherits="FineUI.Pro.AppBox.admin.user_new" %>

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
                        <f:Button ID="btnSaveClose" ValidateForms="SimpleForm1" Icon="SystemSaveClose" OnClick="btnSaveClose_Click"
                            runat="server" Text="保存后关闭">
                        </f:Button>
                    </Items>
                </f:Toolbar>
            </Toolbars>
            <Items>
                <f:Form ID="SimpleForm1" ShowBorder="true" ShowBorderShadow="true" ShowHeader="false" BodyPadding="10" AutoScroll="true" runat="server">
                    <Rows>
                        <f:FormRow runat="server">
                            <Items>
                                <f:TextBox ID="tbxName" runat="server" Label="用户名" Required="true" ShowRedStar="true">
                                </f:TextBox>
                                <f:TextBox ID="tbxRealName" runat="server" Label="中文名" Required="true" ShowRedStar="true">
                                </f:TextBox>
                            </Items>
                        </f:FormRow>
                        <f:FormRow runat="server">
                            <Items>
                                <f:RadioButtonList ID="ddlGender" Label="性别" Required="true" ShowRedStar="true" runat="server">
                                    <f:RadioItem Text="男" Value="男" />
                                    <f:RadioItem Text="女" Value="女" />
                                </f:RadioButtonList>
                                <f:CheckBox ID="cbxEnabled" runat="server" Label="是否启用">
                                </f:CheckBox>
                            </Items>
                        </f:FormRow>
                        <f:FormRow runat="server">
                            <Items>
                                <f:TextBox ID="tbxPassword" runat="server" TextMode="Password" Label="登录密码" Required="true" ShowRedStar="true">
                                </f:TextBox>
                                <f:Label runat="server"></f:Label>
                            </Items>
                        </f:FormRow>
                        <f:FormRow runat="server">
                            <Items>
                                <f:TextBox ID="tbxEmail" runat="server" Label="邮箱" Required="true" ShowRedStar="true"
                                    RegexPattern="EMAIL">
                                </f:TextBox>
                                <f:TextBox ID="tbxCompanyEmail" runat="server" Label="公司邮箱" RegexPattern="EMAIL">
                                </f:TextBox>
                            </Items>
                        </f:FormRow>
                        <f:FormRow runat="server">
                            <Items>
                                <f:TextBox ID="tbxOfficePhone" runat="server" Label="工作电话">
                                </f:TextBox>
                                <f:TextBox ID="tbxOfficePhoneExt" runat="server" Label="分机号">
                                </f:TextBox>
                            </Items>
                        </f:FormRow>
                        <f:FormRow runat="server">
                            <Items>
                                <f:TextBox ID="tbxHomePhone" runat="server" Label="家庭电话">
                                </f:TextBox>
                                <f:TextBox ID="tbxCellPhone" runat="server" Label="手机号">
                                </f:TextBox>
                            </Items>
                        </f:FormRow>
                        <f:FormRow runat="server">
                            <Items>
                                <f:DropDownBox ID="ddbRoles" Label="所属角色" AutoShowClearIcon="true" DataControlID="cblRoles" EnableMultiSelect="true" MultiSelectMode="Tags" runat="server">
                                    <PopPanel>
                                        <f:SimpleForm BodyPadding="10px" AutoScroll="true" ShowBorder="true" ShowHeader="false" Hidden="true" runat="server">
                                            <Items>
                                                <f:CheckBoxList ID="cblRoles" ColumnNumber="3" DataTextField="Name" DataValueField="ID" runat="server">
                                                </f:CheckBoxList>
                                            </Items>
                                        </f:SimpleForm>
                                    </PopPanel>
                                </f:DropDownBox>
                            </Items>
                        </f:FormRow>
                        <f:FormRow runat="server">
                            <Items>
                                <f:DropDownBox ID="ddbTitles" Label="拥有职称" AutoShowClearIcon="true" DataControlID="cblTitles" EnableMultiSelect="true" MultiSelectMode="Tags" runat="server">
                                    <PopPanel>
                                        <f:SimpleForm BodyPadding="10px" AutoScroll="true" ShowBorder="true" ShowHeader="false" Hidden="true" runat="server">
                                            <Items>
                                                <f:CheckBoxList ID="cblTitles" ColumnNumber="3" DataTextField="Name" DataValueField="ID" runat="server">
                                                </f:CheckBoxList>
                                            </Items>
                                        </f:SimpleForm>
                                    </PopPanel>
                                </f:DropDownBox>
                            </Items>
                        </f:FormRow>
                        <f:FormRow runat="server">
                            <Items>
                                <f:DropDownBox ID="ddbDept" Label="所属部门" AutoShowClearIcon="true" runat="server">
                                    <PopPanel>
                                        <f:Grid ID="gridDept" ShowBorder="true" ShowHeader="false" Hidden="true" Width="550" ShowGridHeader="false"
                                            DataIDField="ID" DataTextField="Name"
                                            EnableTree="true" TreeColumn="Name" DataParentIDField="ParentID"
                                            ExpandAllTreeNodes="true"
                                            EnableRowLines="false" EnableAlternateRowColor="false" runat="server">
                                            <Columns>
                                                <f:RenderField ColumnID="Name" DataField="Name" HeaderText="部门名称" ExpandUnusedSpace="true" />
                                            </Columns>
                                        </f:Grid>
                                    </PopPanel>
                                </f:DropDownBox>
                            </Items>
                        </f:FormRow>
                        <f:FormRow runat="server">
                            <Items>
                                <f:TextArea ID="tbxRemark" runat="server" Label="备注">
                                </f:TextArea>
                            </Items>
                        </f:FormRow>
                    </Rows>
                </f:Form>
            </Items>
        </f:Panel>

    </form>

</body>
</html>
