<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="log.aspx.cs" Inherits="FineUI.Pro.AppBox.admin.log" %>

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
                                <f:TwinTriggerBox ID="ttbSearchMessage" runat="server" ShowLabel="false" EmptyText="在错误信息中搜索"
                                    Trigger1Icon="Clear" Trigger2Icon="Search" ShowTrigger1="false" OnTrigger2Click="ttbSearchMessage_Trigger2Click"
                                    OnTrigger1Click="ttbSearchMessage_Trigger1Click">
                                </f:TwinTriggerBox>
                                <f:DropDownList ID="ddlSearchLevel" runat="server" Label="错误级别"
                                    OnSelectedIndexChanged="ddlSearchLevel_SelectedIndexChanged">
                                    <Items>
                                        <f:ListItem Text="全部" Value="ALL" Selected="true" />
                                        <f:ListItem Text="INFO" Value="INFO" />
                                        <f:ListItem Text="DEBUG" Value="DEBUG" />
                                        <f:ListItem Text="WARN" Value="WARN" />
                                        <f:ListItem Text="ERROR" Value="ERROR" />
                                        <f:ListItem Text="FATAL" Value="FATAL" />
                                    </Items>
                                </f:DropDownList>
                                <f:DropDownList ID="ddlSearchRange" runat="server" Label="搜索范围"
                                    OnSelectedIndexChanged="ddlSearchRange_SelectedIndexChanged">
                                    <Items>
                                        <f:ListItem Text="全部" Value="ALL" />
                                        <f:ListItem Text="今天" Value="TODAY" Selected="true" />
                                        <f:ListItem Text="最近三天" Value="LAST3DAYS" />
                                        <f:ListItem Text="最近七天" Value="LAST7DAYS" />
                                        <f:ListItem Text="最近一个月" Value="LASTMONTH" />
                                        <f:ListItem Text="最近一年" Value="LASTYEAR" />
                                    </Items>
                                </f:DropDownList>
                            </Items>
                        </f:FormRow>
                    </Rows>
                </f:Form>
                <f:Grid ID="Grid1" runat="server" BoxFlex="1" ShowBorder="true" ShowBorderShadow="true" ShowHeader="false" EnableCheckBoxSelect="true"
                    DataKeyNames="Logid" DataIDField="Logid"
                    AllowSorting="true" OnSort="Grid1_Sort" SortField="DatetimeX" SortDirection="DESC"
                    AllowPaging="true" IsDatabasePaging="true" OnPageIndexChange="Grid1_PageIndexChange"
                    OnRowCommand="Grid1_RowCommand">
                    <Toolbars>
                        <f:Toolbar ID="Toolbar1" runat="server">
                            <Items>
                                <f:Button ID="btnDeleteSelected" Icon="Delete" runat="server" ClickHandler="onDeleteSelectedClick" Text="删除选中记录">
                                </f:Button>
                            </Items>
                        </f:Toolbar>
                    </Toolbars>
                    <PageItems>
                        <f:ToolbarText runat="server" Text="每页记录数："></f:ToolbarText>
                        <f:DropDownList ID="ddlGridPageSize" Width="80px" OnSelectedIndexChanged="ddlGridPageSize_SelectedIndexChanged" runat="server">
                            <f:ListItem Text="10" Value="10" />
                            <f:ListItem Text="20" Value="20" />
                            <f:ListItem Text="50" Value="50" />
                            <f:ListItem Text="100" Value="100" />
                        </f:DropDownList>
                    </PageItems>
                    <Columns>
                        <f:RowNumberField />
                        <f:BoundField DataField="DatetimeX" SortField="DatetimeX" DataFormatString="{0:yyyy-MM-dd HH:mm}"
                            Width="120px" HeaderText="时间" />
                        <f:BoundField DataField="LogLevel" SortField="LogLevel" Width="50px" HeaderText="级别" />
                        <f:BoundField DataField="Logger" SortField="Logger" Width="100px" HeaderText="源" />
                        <f:BoundField DataField="Message" ExpandUnusedSpace="true" HeaderText="错误信息" />
                        <f:BoundField DataField="Exception" Width="200px" HeaderText="异常信息" />
                        <f:WindowField Icon="Information" ToolTip="查看详细信息" Title="查看详细信息" WindowID="Window1"
                            DataIFrameUrlFields="Logid" DataIFrameUrlFormatString="~/admin/log_view.aspx?id={0}"
                            Width="50px" />
                        <f:LinkButtonField ColumnID="deleteField" Icon="Delete" ToolTip="删除" ConfirmText="确定删除此记录？"
                            ConfirmTarget="Top" CommandName="Delete" Width="50px" />
                    </Columns>
                </f:Grid>
            </Items>
        </f:Panel>
        <f:Window ID="Window1" runat="server" IsModal="true" Hidden="true" Target="Top" EnableResize="true"
            EnableMaximize="true" EnableIFrame="true" Width="800px"
            Height="500px">
        </f:Window>
    </form>
    <script type="text/javascript">
        var Grid1ClientID = '<%= Grid1.ClientID %>';

        function onDeleteSelectedClick(event) {
            var grid = F(Grid1ClientID);
            if (!grid.hasSelection()) {
                F.alert({
                    message: '请至少应该选择一项记录！',
                    target: '_parent'
                });
                return;
            }

            var selectedRows = grid.getSelectedRows();
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
    </script>
</body>
</html>
