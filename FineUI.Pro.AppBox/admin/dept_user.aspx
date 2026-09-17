<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dept_user.aspx.cs" Inherits="FineUI.Pro.AppBox.admin.dept_user" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title></title>

</head>
<body class="f-body-darkerbg">
    <form id="form1" runat="server">
        <f:PageManager ID="PageManager1" runat="server"></f:PageManager>
        <f:RegionPanel ID="RegionPanel1" ShowBorder="false" runat="server" IsViewPort="true" Margin="20px">
            <Regions>
                <f:Region ID="Region1" ShowBorder="true" ShowBorderShadow="true" ShowHeader="false" Width="260" RegionPosition="Left" RegionSplit="true" RegionSplitIcon="false" RegionSplitWidth="10" Layout="Fit" runat="server">
                    <Items>
                        <f:Grid ID="Grid1" runat="server" ShowBorder="true" ShowHeader="false" EnableCheckBoxSelect="false"
                            DataIDField="ID"
                            EnableMultiSelect="false" OnRowClick="Grid1_RowClick" EnableRowClickEvent="true"
                            EnableTree="true" TreeColumn="Name" DataParentIDField="ParentID" ExpandAllTreeNodes="true">
                            <Columns>
                                <f:RowNumberField EnableTreeNumber="true"></f:RowNumberField>
                                <f:BoundField ColumnID="Name" DataField="Name" ExpandUnusedSpace="true" HeaderText="部门名称"></f:BoundField>
                            </Columns>
                        </f:Grid>
                    </Items>
                </f:Region>
                <f:Region ID="Region2" ShowBorder="false" ShowHeader="false" RegionPosition="Center" Layout="VBox" BoxConfigSpace="10" runat="server">
                    <Items>
                        <f:Form ShowBorder="true" ShowBorderShadow="true" BodyPadding="10" RemoveLastFieldsMargin="true" ShowHeader="false" runat="server">
                            <Rows>
                                <f:FormRow runat="server">
                                    <Items>
                                        <f:TwinTriggerBox ID="ttbSearchMessage" runat="server" ShowLabel="false" EmptyText="在用户名称中搜索" Trigger1Icon="Clear" Trigger2Icon="Search" ShowTrigger1="false"
                                            OnTrigger2Click="ttbSearchMessage_Trigger2Click" OnTrigger1Click="ttbSearchMessage_Trigger1Click">
                                        </f:TwinTriggerBox>
                                        <f:Label runat="server"></f:Label>
                                    </Items>
                                </f:FormRow>
                            </Rows>
                        </f:Form>
                        <f:Grid ID="Grid2" runat="server" BoxFlex="1" ShowBorder="true" ShowBorderShadow="true" ShowHeader="false" EnableCheckBoxSelect="true"
                            DataIDField="ID"
                            AllowSorting="true" OnSort="Grid2_Sort" SortField="Name" SortDirection="DESC"
                            AllowPaging="true" IsDatabasePaging="true" OnPageIndexChange="Grid2_PageIndexChange"
                            OnRowCommand="Grid2_RowCommand">
                            <Toolbars>
                                <f:Toolbar ID="Toolbar1" runat="server">
                                    <Items>
                                        <f:Button ID="btnDeleteSelected" Icon="Delete" runat="server" ClickHandler="onDeleteSelectedClick" Text="从当前部门移除选中的用户">
                                        </f:Button>
                                        <f:ToolbarFill runat="server"></f:ToolbarFill>
                                        <f:Button ID="btnNew" runat="server" Icon="Add" OnClick="btnNew_Click" Text="添加用户到当前部门">
                                        </f:Button>
                                    </Items>
                                </f:Toolbar>
                            </Toolbars>
                            <PageItems>
                                <f:ToolbarText runat="server" Text="每页记录数："></f:ToolbarText>
                                <f:DropDownList ID="ddlGridPageSize" Width="80px" OnSelectedIndexChanged="ddlGridPageSize_SelectedIndexChanged" runat="server">
                                    <Items>
                                        <f:ListItem Text="10" Value="10"></f:ListItem>
                                        <f:ListItem Text="20" Value="20"></f:ListItem>
                                        <f:ListItem Text="50" Value="50"></f:ListItem>
                                        <f:ListItem Text="100" Value="100"></f:ListItem>
                                    </Items>
                                </f:DropDownList>
                            </PageItems>
                            <Columns>
                                <f:RowNumberField EnablePagingNumber="true"></f:RowNumberField>
                                <f:BoundField DataField="Name" SortField="Name" Width="100px" HeaderText="用户名"></f:BoundField>
                                <f:BoundField DataField="ChineseName" SortField="ChineseName" Width="100px" HeaderText="中文名"></f:BoundField>
                                <f:CheckBoxField DataField="Enabled" SortField="Enabled" HeaderText="启用" RenderAsStaticField="true" Width="80px"></f:CheckBoxField>
                                <f:BoundField DataField="Gender" SortField="Gender" Width="80px" HeaderText="性别"></f:BoundField>
                                <f:BoundField DataField="Email" SortField="Email" Width="180px" HeaderText="邮箱"></f:BoundField>
                                <f:BoundField DataField="Remark" ExpandUnusedSpace="true" HeaderText="备注"></f:BoundField>
                                <f:WindowField TextAlign="Center" Icon="Information" ToolTip="查看详细信息" Title="查看详细信息" WindowID="Window1" DataIFrameUrlFields="ID" DataIFrameUrlFormatString="~/admin/user_view.aspx?id={0}" Width="50px"></f:WindowField>
                                <f:LinkButtonField ColumnID="deleteField" TextAlign="Center" Icon="Delete" ToolTip="从当前部门中移除此用户" ConfirmText="确定从当前部门中移除此用户？" ConfirmTarget="Top" CommandName="Delete" Width="50px"></f:LinkButtonField>
                            </Columns>
                        </f:Grid>
                    </Items>
                </f:Region>
            </Regions>
        </f:RegionPanel>
        <f:Window ID="Window1" runat="server" IsModal="true" Hidden="true" Target="Top" EnableResize="true" EnableMaximize="true" EnableIFrame="true"
            Width="900px" Height="650px" OnClose="Window1_Close">
        </f:Window>
    </form>
    <script type="text/javascript">
        var Grid2ClientID = '<%= Grid2.ClientID %>';

        function onDeleteSelectedClick(event) {
            var grid = F(Grid2ClientID);
            if (!grid.hasSelection()) {
                F.alert({
                    message: '请至少应该选择一项记录！',
                    target: '_parent'
                });
                return;
            }

            var selectedRows = grid.getSelectedRows();
            F.confirm({
                message: F.rawHtml('确定要从当前部门移除选中的&nbsp;<span class="highlight">{0}</span>&nbsp;项记录吗？', selectedRows.length),
                messageIcon: 'warning',
                target: '_top',
                ok: function () {
                    F.customEvent('Grid2_DeleteRows', {
                        rowIDs: selectedRows
                    });
                }
            });
        }
    </script>
</body>
</html>
