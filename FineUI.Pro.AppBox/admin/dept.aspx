<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dept.aspx.cs" Inherits="FineUI.Pro.AppBox.admin.dept" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title></title>
</head>
<body class="f-body-darkerbg">
    <form id="form1" runat="server">
        <f:PageManager ID="PageManager1" runat="server" />
        <f:Panel ID="Panel1" runat="server" IsViewPort="true" Margin="20px" ShowBorder="false" ShowHeader="false" Layout="Fit">
            <Items>
                <f:Grid ID="Grid1" runat="server" ShowBorder="true" ShowBorderShadow="true" ShowHeader="false" EnableCheckBoxSelect="false"
                    DataIDField="ID"
                    EnableTree="true" TreeColumn="Name" DataParentIDField="ParentID" ExpandAllTreeNodes="true"
                    OnRowCommand="Grid1_RowCommand" EnableMultiSelect="false">
                    <Columns>
                        <f:RowNumberField EnableTreeNumber="true" />
                        <f:BoundField ColumnID="Name" DataField="Name" HeaderText="部门名称" Width="180px" />
                        <f:BoundField DataField="Remark" HeaderText="部门描述" ExpandUnusedSpace="true" />
                        <f:BoundField DataField="SortIndex" HeaderText="排序" Width="80px" />
                        <f:WindowField ColumnID="editField" TextAlign="Center" Icon="Pencil" ToolTip="编辑"
                            WindowID="Window1" Title="编辑" DataIFrameUrlFields="ID" DataIFrameUrlFormatString="~/admin/dept_edit.aspx?id={0}"
                            Width="50px" />
                        <f:LinkButtonField ColumnID="deleteField" TextAlign="Center" Icon="Delete" ToolTip="删除"
                            ConfirmText="确定删除此记录？" ConfirmTarget="Top" CommandName="Delete" Width="50px" />
                    </Columns>
                    <Toolbars>
                        <f:Toolbar ID="Toolbar1" Position="Top" runat="server">
                            <Items>
                                <f:ToolbarFill runat="server"></f:ToolbarFill>
                                <f:Button ID="btnNew" runat="server" Icon="Add" ClickHandler="onNewClick" Text="新增部门">
                                </f:Button>
                            </Items>
                        </f:Toolbar>
                    </Toolbars>

                </f:Grid>
            </Items>
        </f:Panel>
        <f:Window ID="Window1" runat="server" IsModal="true" Hidden="true"
            Target="Top" EnableResize="true" EnableMaximize="true" EnableIFrame="true"
            Width="900px" Height="650px" OnClose="Window1_Close">
        </f:Window>
    </form>
    <script type="text/javascript">
        function onNewClick(event) {
            F('<%= Window1.ClientID %>').show('<%= ResolveUrl("~/admin/dept_new.aspx") %>', '新增部门');
        }
    </script>
</body>
</html>
