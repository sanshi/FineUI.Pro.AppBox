<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="power.aspx.cs" Inherits="FineUI.Pro.AppBox.admin.power" %>

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
                                <f:TwinTriggerBox ID="ttbSearchMessage" runat="server" ShowLabel="false" EmptyText="在权限名称或标题中搜索"
                                    Trigger1Icon="Clear" Trigger2Icon="Search" ShowTrigger1="false" OnTrigger2Click="ttbSearchMessage_Trigger2Click"
                                    OnTrigger1Click="ttbSearchMessage_Trigger1Click">
                                </f:TwinTriggerBox>
                                <f:Label runat="server"></f:Label>
                            </Items>
                        </f:FormRow>
                    </Rows>
                </f:Form>
                <f:Grid ID="Grid1" runat="server" BoxFlex="1" ShowBorder="true" ShowBorderShadow="true" ShowHeader="false" EnableCheckBoxSelect="true" 
                    DataIDField="ID"
                    AllowSorting="true" OnSort="Grid1_Sort" SortField="GroupName" SortDirection="DESC"
                    AllowPaging="true" IsDatabasePaging="true" OnPageIndexChange="Grid1_PageIndexChange"
                    OnRowCommand="Grid1_RowCommand">
                    <Toolbars>
                        <f:Toolbar ID="Toolbar1" runat="server">
                            <Items>
                                <%--<f:Button ID="btnDeleteSelected" Icon="Delete" runat="server" Text="删除选中记录" OnClick="btnDeleteSelected_Click">
                                </f:Button>--%>
                                <f:ToolbarFill runat="server"></f:ToolbarFill>
                                <f:Button ID="btnNew" runat="server" Icon="Add" ClickHandler="onNewClick" Text="新增权限">
                                </f:Button>
                            </Items>
                        </f:Toolbar>
                    </Toolbars>
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
                    <Columns>
                        <f:RowNumberField />
                        <f:BoundField DataField="GroupName" SortField="GroupName" Width="120px" HeaderText="分组名称" />
                        <f:BoundField DataField="Name" SortField="Name" Width="180px" HeaderText="权限名称" />
                        <f:BoundField DataField="Title" SortField="Title" Width="180px" HeaderText="标题" />
                        <f:BoundField DataField="Remark" ExpandUnusedSpace="true" HeaderText="备注" />
                        <f:WindowField ColumnID="editField" TextAlign="Center" Icon="Pencil" ToolTip="编辑"
                            WindowID="Window1" Title="编辑" DataIFrameUrlFields="ID" DataIFrameUrlFormatString="~/admin/power_edit.aspx?id={0}"
                            Width="50px" />
                        <f:LinkButtonField ColumnID="deleteField" TextAlign="Center" Icon="Delete" ToolTip="删除"
                            ConfirmText="确定删除此记录？" ConfirmTarget="Top" CommandName="Delete" Width="50px" />
                    </Columns>
                </f:Grid>
            </Items>
        </f:Panel>
        <f:Window ID="Window1" runat="server" IsModal="true" Hidden="true" Target="Top"
            EnableResize="true" EnableMaximize="true" EnableIFrame="true"
            Width="900px" Height="650px" OnClose="Window1_Close">
        </f:Window>
    </form>
    <script type="text/javascript">
        function onNewClick(event) {
            F('<%= Window1.ClientID %>').show('<%= ResolveUrl("~/admin/power_new.aspx") %>', '新增权限');
        }
    </script>
</body>
</html>
