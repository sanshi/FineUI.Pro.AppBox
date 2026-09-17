<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="title_user_addnew.aspx.cs"
    Inherits="FineUI.Pro.AppBox.admin.title_user_addnew" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title></title>
</head>
<body class="f-body-darkerbg">
    <form id="form1" runat="server">
        <f:PageManager ID="PageManager1" runat="server" />
        <f:Panel ID="Panel1" ShowBorder="false" ShowHeader="false" IsViewPort="true" BodyPadding="10" Layout="VBox" runat="server">
            <Toolbars>
                <f:Toolbar ID="Toolbar1" runat="server">
                    <Items>
                        <f:Button ID="btnClose" Icon="SystemClose" runat="server" ClickHandler="onCloseActiveWindowClick" Text="关闭">
                        </f:Button>
                        <f:ToolbarSeparator runat="server"></f:ToolbarSeparator>
                        <f:Button ID="btnSaveClose" Icon="SystemSaveClose" OnClick="btnSaveClose_Click" runat="server" Text="选择后关闭">
                        </f:Button>
                        <f:ToolbarFill runat="server"></f:ToolbarFill>
                        <f:TwinTriggerBox ID="ttbSearchMessage" Width="160px" runat="server" ShowLabel="false"
                            EmptyText="在用户名称中搜索" Trigger1Icon="Clear" Trigger2Icon="Search" ShowTrigger1="false"
                            OnTrigger2Click="ttbSearchMessage_Trigger2Click" OnTrigger1Click="ttbSearchMessage_Trigger1Click">
                        </f:TwinTriggerBox>
                    </Items>
                </f:Toolbar>
            </Toolbars>
            <Items>
                <f:Panel ShowBorder="true" ShowBorderShadow="true" ShowHeader="false" BodyPadding="10" MarginBottom="10" runat="server">
                    <Items>
                        <f:Label ID="labSelectedUsers" EncodeText="false" CssStyle="margin:0;" runat="server"></f:Label>
                    </Items>
                </f:Panel>
                <f:Grid ID="Grid1" BoxFlex="1" runat="server" ShowBorder="true" ShowHeader="false" EnableCheckBoxSelect="true"
                    DataIDField="ID"
                    AllowSorting="true" OnSort="Grid1_Sort" SortField="Name" SortDirection="DESC"
                    AllowPaging="true" IsDatabasePaging="true" OnPageIndexChange="Grid1_PageIndexChange"
                    ClearSelectionBeforePaging="false" ClearSelectionBeforeBinding="false" KeepPagedSelection="true" KeepCurrentSelection="true">
                    <Columns>
                        <f:RowNumberField EnablePagingNumber="true" />
                        <f:BoundField ColumnID="Name" DataField="Name" SortField="Name" Width="100px" HeaderText="用户名" />
                        <f:BoundField ColumnID="ChineseName" DataField="ChineseName" SortField="RealName" Width="100px" HeaderText="中文名" />
                        <f:CheckBoxField DataField="Enabled" SortField="Enabled" HeaderText="启用" RenderAsStaticField="true" Width="80px" />
                        <f:BoundField DataField="Gender" SortField="Gender" Width="80px" HeaderText="性别" />
                        <f:BoundField DataField="Email" SortField="Email" Width="180px" HeaderText="邮箱" />
                        <f:BoundField DataField="Remark" ExpandUnusedSpace="true" HeaderText="备注" />
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
                    <Listeners>
                        <f:Listener Event="dataload" Handler="onGrid1DataLoad"></f:Listener>
                        <f:Listener Event="selectionchange" Handler="onGrid1SelectionChange"></f:Listener>
                    </Listeners>
                </f:Grid>
            </Items>
        </f:Panel>

        <f:HiddenField ID="hfTitleID" runat="server"></f:HiddenField>
    </form>
    <script>
        var Grid1ClientID = '<%= Grid1.ClientID %>';
        var labSelectedUsersClientID = '<%= labSelectedUsers.ClientID %>';

        // 缓存的行数据
        var cachedRows = {};

        function updateLabelResult() {
            var labSelectedUsers = F(labSelectedUsersClientID);
            var grid1 = F(Grid1ClientID);

            var selectedRowIds = grid1.getSelectedRows();

            if (!selectedRowIds.length) {
                labSelectedUsers.setText('尚未选中任何用户');
            } else {
                var result = [];
                $.each(selectedRowIds, function (index, item) {
                    var rowId = item, rowData = cachedRows[rowId];

                    var name = rowData.values['Name'];
                    var chineseName = rowData.values['ChineseName'];

                    result.push(`<strong>${F.htmlEncode(chineseName)}</strong>（${F.htmlEncode(name)}）`);
                });
                labSelectedUsers.setText(`选中了 <strong>${result.length}</strong> 位用户：${result.join(', ')}`);
            }
        }

        // 缓存当前页选中行的数据
        function cacheCurrentPage() {
            $.each(F(Grid1ClientID).getSelectedRows(true), function (index, item) {
                var rowId = item.id;
                if (!cachedRows[rowId]) {
                    cachedRows[rowId] = item;
                }
            });
        }

        function onGrid1SelectionChange(event) {
            cacheCurrentPage();
            updateLabelResult();
        }

        function onGrid1DataLoad(event) {
            cacheCurrentPage();
            updateLabelResult();
        }

    </script>
</body>
</html>
