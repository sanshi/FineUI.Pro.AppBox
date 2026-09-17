<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="notice.aspx.cs" Inherits="FineUI.Pro.AppBox.Public.notice" %>

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
                <f:Form ID="Form2" ShowBorder="true" ShowBorderShadow="true" BodyPadding="10" RemoveLastFieldsMargin="true" ShowHeader="false" runat="server">
                    <Rows>
                        <f:FormRow ID="FormRow1" runat="server">
                            <Items>
                                <f:TwinTriggerBox ID="ttbSearchTitle" runat="server" ShowLabel="false" EmptyText="在公告标题中搜索"
                                    Trigger1Icon="Clear" Trigger2Icon="Search" ShowTrigger1="false" OnTrigger2Click="ttbSearchTitle_Trigger2Click"
                                    OnTrigger1Click="ttbSearchTitle_Trigger1Click">
                                </f:TwinTriggerBox>
                                <f:Label ID="labSignedIn" runat="server" ShowLabel="false" CssStyle="color:#888;text-align:right;"></f:Label>
                            </Items>
                        </f:FormRow>
                    </Rows>
                </f:Form>
                <f:Grid ID="Grid1" runat="server" BoxFlex="1" ShowBorder="true" ShowBorderShadow="true" Title="通知公告" ShowHeader="true" EnableCheckBoxSelect="false"
                    DataIDField="ID" AllowPaging="true" PageSize="5" IsDatabasePaging="true"
                    OnPageIndexChange="Grid1_PageIndexChange">
                    <Columns>
                        <f:RowNumberField />
                        <f:BoundField DataField="Title" ExpandUnusedSpace="true" HeaderText="标题" />
                        <f:BoundField DataField="Department" Width="120px" HeaderText="发布部门" />
                        <f:BoundField DataField="PublishTime" Width="150px" HeaderText="发布时间" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                        <f:WindowField ColumnID="viewField" TextAlign="Center" Icon="Find" ToolTip="查看全文" WindowID="Window1"
                            Title="公告详情" DataIFrameUrlFields="ID" DataIFrameUrlFormatString="~/public/notice_detail.aspx?id={0}"
                            Width="60px" />
                    </Columns>
                </f:Grid>
            </Items>
        </f:Panel>
        <f:Window ID="Window1" runat="server" IsModal="true" Hidden="true" Target="Top"
            EnableResize="true" EnableMaximize="true" EnableIFrame="true"
            Width="760px" Height="520px">
        </f:Window>
    </form>
</body>
</html>
