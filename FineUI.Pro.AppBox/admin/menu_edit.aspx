<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="menu_edit.aspx.cs" Inherits="FineUI.Pro.AppBox.admin.menu_edit" %>

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
                        <f:TextBox ID="tbxName" runat="server" Label="菜单名称" Required="true" ShowRedStar="true">
                        </f:TextBox>
                        <f:DropDownBox ID="ddbParent" Label="上级菜单" AutoShowClearIcon="true" runat="server">
                            <PopPanel>
                                <f:Grid ID="Grid1" ShowBorder="true" ShowHeader="false" Hidden="true" Width="550" ShowGridHeader="false"
                                    DataIDField="ID" DataTextField="Name"
                                    EnableTree="true" TreeColumn="Name" DataParentIDField="ParentID"
                                    ExpandAllTreeNodes="true" DisableUnselectableRows="true"
                                    EnableRowLines="false" EnableAlternateRowColor="false"
                                    OnRowDataBound="Grid1_RowDataBound" runat="server">
                                    <Columns>
                                        <f:RenderField ColumnID="Name" DataField="Name" HeaderText="菜单名称" ExpandUnusedSpace="true" />
                                    </Columns>
                                </f:Grid>
                            </PopPanel>
                        </f:DropDownBox>
                        <f:NumberBox ID="tbxSortIndex" Label="排序" Required="true" ShowRedStar="true" runat="server">
                        </f:NumberBox>
                        <f:TextBox ID="tbxViewPower" runat="server" Label="浏览权限">
                        </f:TextBox>
                        <f:TextBox ID="tbxUrl" runat="server" Label="链接">
                        </f:TextBox>
                        <f:TextBox ID="tbxIcon" runat="server" Label="图标">
                        </f:TextBox>
                        <f:RadioButtonList ID="iconList" ColumnNumber="4" ShowEmptyLabel="true" runat="server">
                        </f:RadioButtonList>
                        <f:TextArea ID="tbxRemark" runat="server" Label="备注">
                        </f:TextArea>
                    </Items>
                </f:SimpleForm>
            </Items>
        </f:Panel>
    </form>
    <script type="text/javascript">
        F.ready(function () {
            var iconList = F('<%= iconList.ClientID %>');
            var tbxIcon = F('<%= tbxIcon.ClientID %>');

            iconList.on('change', function () {
                tbxIcon.setValue(iconList.getValue());
            });

            tbxIcon.on('change', function () {
                iconList.setValue(tbxIcon.getValue());
            });
        });
    </script>
</body>
</html>
