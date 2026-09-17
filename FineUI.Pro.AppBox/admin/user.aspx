<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="user.aspx.cs" Inherits="FineUI.Pro.AppBox.admin.user" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title></title>
</head>
<body class="f-body-darkerbg">
    <form id="form1" runat="server">
        <f:PageManager ID="PageManager1" runat="server" />
        <f:Panel ID="Panel1" runat="server" IsViewPort="true" Margin="20px" ShowBorder="false" Layout="VBox" BoxConfigSpace="10" ShowHeader="false">
            <Items>
                <f:Form ShowBorder="true" ShowBorderShadow="true" BodyPadding="10" RemoveLastFieldsMargin="true" ShowHeader="false" runat="server">
                    <Rows>
                        <f:FormRow runat="server">
                            <Items>
                                <f:TwinTriggerBox ID="ttbSearchMessage" runat="server" ShowLabel="false" EmptyText="在用户名称中搜索"
                                    Trigger1Icon="Clear" Trigger2Icon="Search" ShowTrigger1="false" OnTrigger2Click="ttbSearchMessage_Trigger2Click"
                                    OnTrigger1Click="ttbSearchMessage_Trigger1Click">
                                </f:TwinTriggerBox>
                                <f:RadioButtonList ID="rblEnableStatus" OnSelectedIndexChanged="rblEnableStatus_SelectedIndexChanged"
                                    Label="启用状态" ColumnNumber="3" runat="server">
                                    <f:RadioItem Text="全部" Selected="true" Value="all" />
                                    <f:RadioItem Text="启用" Value="enabled" />
                                    <f:RadioItem Text="禁用" Value="disabled" />
                                </f:RadioButtonList>
                            </Items>
                        </f:FormRow>
                    </Rows>
                </f:Form>
                <f:Grid ID="Grid1" runat="server" BoxFlex="1" ShowBorder="true" ShowBorderShadow="true" ShowHeader="false" EnableCheckBoxSelect="true"
                    DataIDField="ID"
                    AllowSorting="true" OnSort="Grid1_Sort" SortField="Name" SortDirection="DESC"
                    AllowPaging="true" IsDatabasePaging="true"
                    OnRowCommand="Grid1_RowCommand" OnPageIndexChange="Grid1_PageIndexChange">
                    <Columns>
                        <f:RowNumberField EnablePagingNumber="true" />
                        <f:BoundField DataField="Name" SortField="Name" Width="100px" HeaderText="用户名" />
                        <f:BoundField DataField="ChineseName" SortField="ChineseName" Width="100px" HeaderText="中文名" />
                        <f:CheckBoxField DataField="Enabled" SortField="Enabled" HeaderText="启用" RenderAsStaticField="true" Width="80px" />
                        <f:BoundField DataField="Gender" SortField="Gender" Width="80px" HeaderText="性别" />
                        <f:BoundField DataField="Email" SortField="Email" Width="180px" HeaderText="邮箱" />
                        <f:BoundField DataField="Remark" ExpandUnusedSpace="true" HeaderText="备注" />
                        <f:WindowField TextAlign="Center" Icon="Information" ToolTip="查看详细信息" Title="查看详细信息"
                            WindowID="Window1" DataIFrameUrlFields="ID" DataIFrameUrlFormatString="~/admin/user_view.aspx?id={0}"
                            Width="50px" />
                        <f:WindowField ColumnID="changePasswordField" TextAlign="Center" Icon="Key" ToolTip="修改密码"
                            WindowID="Window1" Title="修改密码" DataIFrameUrlFields="ID" DataIFrameUrlFormatString="~/admin/user_changepassword.aspx?id={0}"
                            Width="50px" />
                        <f:WindowField ColumnID="editField" TextAlign="Center" Icon="Pencil" ToolTip="编辑"
                            WindowID="Window1" Title="编辑" DataIFrameUrlFields="ID" DataIFrameUrlFormatString="~/admin/user_edit.aspx?id={0}"
                            Width="50px" />
                        <f:LinkButtonField ColumnID="deleteField" TextAlign="Center" Icon="Delete" ToolTip="删除"
                            ConfirmText="确定删除此记录？" ConfirmTarget="Top" CommandName="Delete" Width="50px" />
                    </Columns>
                    <PageItems>
                        <f:ToolbarText runat="server" Text="每页记录数："></f:ToolbarText>
                        <f:DropDownList ID="ddlGridPageSize" Width="80px" OnSelectedIndexChanged="ddlGridPageSize_SelectedIndexChanged" runat="server">
                            <Items>
                                <f:ListItem Text="10" Value="10" />
                                <f:ListItem Text="20" Value="20" />
                                <f:ListItem Text="50" Value="50" />
                                <f:ListItem Text="100" Value="100" />
                            </Items>
                        </f:DropDownList>
                    </PageItems>
                    <Toolbars>
                        <f:Toolbar ID="Toolbar1" runat="server">
                            <Items>
                                <f:Button ID="btnDeleteSelected" Icon="Delete" runat="server" ClickHandler="onDeleteSelectedClick" Text="删除选中记录">
                                </f:Button>
                                <f:ToolbarSeparator runat="server"></f:ToolbarSeparator>
                                <f:Button ID="btnChangeEnableUsers" Icon="GroupEdit" runat="server" Text="设置启用状态">
                                    <Menu runat="server">
                                        <f:MenuButton ID="btnEnableUsers" runat="server" ClickHandler="onEnableSelectedClick" Text="启用选中记录">
                                        </f:MenuButton>
                                        <f:MenuButton ID="btnDisableUsers" runat="server" ClickHandler="onDisableSelectedClick" Text="禁用选中记录">
                                        </f:MenuButton>
                                    </Menu>
                                </f:Button>
                                <f:ToolbarFill runat="server"></f:ToolbarFill>
                                <f:Button ID="btnNew" runat="server" Icon="Add" ClickHandler="onNewClick" Text="新增用户">
                                </f:Button>
                            </Items>
                        </f:Toolbar>
                    </Toolbars>
                </f:Grid>
            </Items>
        </f:Panel>
        <f:Window ID="Window1" runat="server" IsModal="true" Hidden="true" Target="Top" EnableResize="true"
            EnableMaximize="true" EnableIFrame="true"
            Width="900px" Height="650px" OnClose="Window1_Close">
        </f:Window>
    </form>
    <script type="text/javascript">
        var Grid1ClientID = '<%= Grid1.ClientID %>';

        function getSelectedUserRows() {
            var grid = F(Grid1ClientID);
            if (!grid.hasSelection()) {
                F.alert({
                    message: '请至少应该选择一项记录！',
                    target: '_parent'
                });
                return null;
            }
            return grid.getSelectedRows();
        }

        function onDeleteSelectedClick(event) {
            var selectedRows = getSelectedUserRows();
            if (!selectedRows) {
                return;
            }

            F.confirm({
                message: F.rawHtml('确定要删除选中的&nbsp;<span class="highlight">{0}</span>&nbsp;项记录吗？', selectedRows.length),
                messageIcon: 'warning',
                target: '_top',
                ok: function () {
                    F.customEvent('Grid1_DeleteRows', {
                        rowIDs: selectedRows
                    });
                }
            });
        }

        function confirmEnableStatus(action, actionText) {
            var selectedRows = getSelectedUserRows();
            if (!selectedRows) {
                return;
            }

            F.confirm({
                message: F.rawHtml('确定要{0}选中的&nbsp;<span class="highlight">{1}</span>&nbsp;项记录吗？', actionText, selectedRows.length),
                messageIcon: 'warning',
                target: '_top',
                ok: function () {
                    F.customEvent('Grid1_EnableRows', {
                        action: action,
                        rowIDs: selectedRows
                    });
                }
            });
        }

        function onEnableSelectedClick(event) {
            confirmEnableStatus('enable', '启用');
        }

        function onDisableSelectedClick(event) {
            confirmEnableStatus('disable', '禁用');
        }

        function onNewClick(event) {
            F('<%= Window1.ClientID %>').show('<%= ResolveUrl("~/admin/user_new.aspx") %>', '新增用户');
        }
    </script>
</body>
</html>
