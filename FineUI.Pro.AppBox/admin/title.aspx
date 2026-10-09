<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="title.aspx.cs" Inherits="FineUI.Pro.AppBox.admin.title" %>

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
                                <f:TwinTriggerBox ID="ttbSearchMessage" runat="server" ShowLabel="false" EmptyText="在职称名称中搜索" Trigger1Icon="Clear"
                                    Trigger2Icon="Search" ShowTrigger1="false" OnTrigger2Click="ttbSearchMessage_Trigger2Click"
                                    OnTrigger1Click="ttbSearchMessage_Trigger1Click">
                                </f:TwinTriggerBox>
                                <f:Label runat="server"></f:Label>
                            </Items>
                        </f:FormRow>
                    </Rows>
                </f:Form>
                <f:Grid ID="Grid1" runat="server" BoxFlex="1" ShowBorder="true" ShowBorderShadow="true" ShowHeader="false" EnableCheckBoxSelect="true"
                    DataIDField="ID" AllowSorting="true" OnSort="Grid1_Sort" SortField="Name" SortDirection="DESC" AllowPaging="true" IsDatabasePaging="true"
                    OnRowCommand="Grid1_RowCommand" OnPageIndexChange="Grid1_PageIndexChange">
                    <Columns>
                        <f:RowNumberField />
                        <f:RenderField DataField="Name" SortField="Name" Width="180px" HeaderText="职称名称" />
                        <%--<f:RenderCheckField DataField="Enabled" HeaderText="启用" CommandName="Enabled" Width="80px" RenderAsStaticField="true" />--%>
                        <f:RenderField DataField="Remark" ExpandUnusedSpace="true" HeaderText="备注" />
                        <f:RenderField ColumnID="editField" TextAlign="Center" Width="50px">
                            <Commands>
                                <f:Command CommandName="Edit" Icon="Pencil" ToolTip="编辑" WindowID="Window1" WindowTitle="编辑" WindowIFrameUrlFields="ID"
                                    WindowIFrameUrlFormatString="~/admin/title_edit.aspx?id={0}" />
                            </Commands>
                        </f:RenderField>
                        <f:RenderField ColumnID="deleteField" TextAlign="Center" Width="50px">
                            <Commands>
                                <f:Command Icon="Delete" ToolTip="删除" ConfirmText="确定删除此记录？" ConfirmTarget="Top" CommandName="Delete" />
                            </Commands>
                        </f:RenderField>
                    </Columns>
                    <Toolbars>
                        <f:Toolbar ID="Toolbar1" runat="server">
                            <Items>
                                <f:ToolbarFill runat="server"></f:ToolbarFill>
                                <f:Button ID="btnNew" runat="server" Icon="Add" ClickHandler="onNewClick" Text="新增职称">
                                </f:Button>
                            </Items>
                        </f:Toolbar>
                    </Toolbars>
                </f:Grid>
            </Items>
        </f:Panel>
        <f:Window ID="Window1" runat="server" IsModal="true" Hidden="true" Target="Top" EnableResize="true" EnableMaximize="true" EnableIFrame="true"
            Width="900px" Height="650px" OnClose="Window1_Close">
        </f:Window>
    </form>
    <script type="text/javascript">
        function onNewClick(event) {
            F('<%= Window1.ClientID %>').show('<%= ResolveUrl("~/admin/title_new.aspx") %>', '新增职称');
        }

    </script>
</body>
</html>
