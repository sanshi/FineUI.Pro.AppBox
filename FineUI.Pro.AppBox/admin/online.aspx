<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="online.aspx.cs" Inherits="FineUI.Pro.AppBox.admin.online" %>

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
                                <f:TwinTriggerBox ID="ttbSearchMessage" runat="server" ShowLabel="false" EmptyText="在用户名中搜索"
                                    Trigger1Icon="Clear" Trigger2Icon="Search" ShowTrigger1="false" OnTrigger2Click="ttbSearchMessage_Trigger2Click"
                                    OnTrigger1Click="ttbSearchMessage_Trigger1Click">
                                </f:TwinTriggerBox>
                                <f:Label runat="server"></f:Label>
                            </Items>
                        </f:FormRow>
                    </Rows>
                </f:Form>
                <f:Grid ID="Grid1" runat="server" BoxFlex="1" ShowBorder="true" ShowBorderShadow="true" ShowHeader="false" EnableCheckBoxSelect="false"
                    DataIDField="ID"
                    AllowSorting="true" OnSort="Grid1_Sort" SortField="UpdateTime" SortDirection="DESC"
                    AllowPaging="true" IsDatabasePaging="true" OnPageIndexChange="Grid1_PageIndexChange">
                    <Columns>
                        <f:RowNumberField />
                        <f:BoundField DataField="UpdateTime" SortField="UpdateTime" DataFormatString="{0:yyyy-MM-dd HH:mm}"
                            Width="200px" HeaderText="最后操作时间" />
                        <f:BoundField DataField="LoginTime" SortField="LoginTime" Width="200px" DataFormatString="{0:yyyy-MM-dd HH:mm}"
                            HeaderText="登录时间" />
                        <f:BoundField DataField="UserName" SortField="UserName" Width="100px" HeaderText="用户名" />
                        <f:BoundField DataField="UserChineseName" SortField="UserChineseName" Width="100px" HeaderText="中文名" />
                        <f:BoundField DataField="IPAdddress" ExpandUnusedSpace="true" HeaderText="IP地址" />
                        <f:WindowField Text="查看" Title="查看" WindowID="Window1" DataIFrameUrlFields="UserID"
                            DataIFrameUrlFormatString="~/admin/user_view.aspx?id={0}" Width="50px" />
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
                </f:Grid>
            </Items>
        </f:Panel>
        <f:Window ID="Window1" runat="server" IsModal="true" Hidden="true" Target="Top" EnableResize="true"
            EnableMaximize="true" EnableIFrame="true" Width="800px" Height="500px">
        </f:Window>
    </form>
</body>
</html>
