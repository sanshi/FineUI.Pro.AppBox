<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="FineUI.Pro.AppBox.main" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>首页</title>
    <link href="res/css/index.css" rel="stylesheet" />
    <link href="res/css/mobileview.css" rel="stylesheet" />
</head>
<body class="f-body-darkerbg">
    <form id="form1" runat="server">
        <f:PageManager ID="PageManager1" runat="server"></f:PageManager>
        <f:Panel ID="mainPanel" Layout="Region" CssClass="mainpanel" ShowBorder="false" ShowHeader="false" IsViewPort="true" runat="server">
            <Items>
                <f:Panel ID="sidebarRegion" CssClass="sidebarregion" RegionPosition="Left" ShowBorder="false" Width="260" ShowHeader="false"
                    EnableCollapse="false" Collapsed="false" Layout="VBox" runat="server"
                    RegionSplit="true" RegionSplitIcon="false" RegionSplitWidth="3" RegionSplitTransparent="true">
                    <Items>
                        <f:ContentPanel CssClass="topregion" ShowBorder="false" ShowHeader="false" runat="server">
                            <div id="sideheader" class="f-widget-header f-mainheader">
                                <a class="logo" href="./" title="FineUI.Pro.AppBox" id="logoTitle" runat="server">FineUI.Pro.AppBox</a>
                                <div class="logo-subtitle">EF</div>
                            </div>
                        </f:ContentPanel>
                        <f:Panel ID="leftPanel" CssClass="leftregion" BoxFlex="1" ShowBorder="false" ShowHeader="false" Layout="Fit" runat="server">
                            <Items>
                                <f:Tree ID="treeMenu" ShowBorder="false" ShowHeader="false" EnableSingleClickExpand="true"
                                    HideHScrollbar="true" HideVScrollbar="true" ExpanderToRight="true" HeaderStyle="true" AllHeaderStyle="true" runat="server">
                                </f:Tree>
                            </Items>
                        </f:Panel>
                    </Items>
                    <Listeners>
                        <f:Listener Event="splitdrag" Handler="onSidebarSplitDrag" />
                    </Listeners>
                </f:Panel>
                <f:Panel ID="bodyRegion" CssClass="bodyregion" RegionPosition="Center" ShowBorder="false" ShowHeader="false" Layout="VBox" runat="server">
                    <Items>
                        <f:ContentPanel ID="topPanel" CssClass="topregion" ShowBorder="false" ShowHeader="false" runat="server">
                            <div id="header" class="f-widget-header f-mainheader">
                                <div class="header-left">
                                    <f:Button runat="server" ID="btnCollapseSidebar" CssClass="icononlyaction" ToolTip="折叠/展开侧边栏" IconAlign="Top" IconFont="_Fold"
 EnableDefaultState="false" EnableDefaultCorner="false" TabIndex="-1">
                                        <Listeners>
                                            <f:Listener Event="click" Handler="onFoldClick" />
                                        </Listeners>
                                    </f:Button>
                                </div>
                                <div class="header-right">
                                    <f:Button CssClass="icontopaction" Text="下载源码" IconAlign="Top" IconFont="_Download"
 EnableDefaultState="false" EnableDefaultCorner="false" runat="server">
                                        <Listeners>
                                            <f:Listener Event="click" Handler="onDownloadClick"></f:Listener>
                                        </Listeners>
                                    </f:Button>
                                    <f:Button CssClass="icontopaction" ID="btnThemeSelect" Text="主题仓库" IconAlign="Top" IconFont="_Skin"
 EnableDefaultState="false" EnableDefaultCorner="false" TabIndex="-1" runat="server">
                                        <Listeners>
                                            <f:Listener Event="click" Handler="onThemeSelectClick" />
                                        </Listeners>
                                    </f:Button>
                                    <f:Button runat="server" ID="btnUserName" CssClass="userpicaction" Text="三生石上" IconUrl="~/res/images/my_face_80.jpg" IconAlign="Left"
 EnableDefaultState="false" EnableDefaultCorner="false">
                                        <Menu runat="server">
                                            <f:MenuButton ID="btnHelp" Icon="Help" Text="系统帮助" runat="server">
                                            </f:MenuButton>
                                            <f:MenuSeparator runat="server">
                                            </f:MenuSeparator>
                                            <f:MenuButton runat="server" Text="安全退出" ConfirmText="确定退出系统？" OnClick="btnExit_Click">
                                            </f:MenuButton>
                                        </Menu>
                                    </f:Button>
                                </div>
                            </div>
                        </f:ContentPanel>
                        <f:TabStrip ID="mainTabStrip" CssClass="centerregion" ShowInkBar="true" InkBarPosition="Bottom" BoxFlex="1" ShowBorder="true" EnableTabCloseMenu="true" runat="server">
                            <Tabs>
                                <f:Tab ID="tabHomepage" Title="首页" IconFont="_Home" EnableIFrame="true" IFrameUrl="~/admin/default.aspx" runat="server">
                                </f:Tab>
                            </Tabs>
                            <Tools>
                                <f:Tool runat="server" IconFont="_Refresh" CssClass="tabtool" ToolTip="刷新本页" ID="toolRefresh">
                                    <Listeners>
                                        <f:Listener Event="click" Handler="onToolRefreshClick" />
                                    </Listeners>
                                </f:Tool>
                                <f:Tool runat="server" IconFont="_Maximize" CssClass="tabtool" ToolTip="最大化" ID="toolMaximize">
                                    <Listeners>
                                        <f:Listener Event="click" Handler="onToolMaximizeClick" />
                                    </Listeners>
                                </f:Tool>
                            </Tools>
                        </f:TabStrip>
                    </Items>
                </f:Panel>
            </Items>
        </f:Panel>

        <f:Window ID="windowThemeRoller" runat="server" Hidden="true" EnableIFrame="true" ClearIFrameAfterClose="false"
            IFrameUrl="~/themes.aspx" IsModal="true" Width="850" Height="600" EnableClose="true" EnableMaximize="true" EnableResize="true" WindowPosition="Center">
        </f:Window>

    </form>
    <script>
        var PARAMS = {
            mainPanel: '<%= mainPanel.ClientID %>',
            mainTabStrip: '<%= mainTabStrip.ClientID %>',
            treeMenu: '<%= treeMenu.ClientID %>',
            sidebarRegion: '<%= sidebarRegion.ClientID %>',
            topPanel: '<%= topPanel.ClientID %>',
            btnCollapseSidebar: '<%= btnCollapseSidebar.ClientID %>',
            tabHomepage: '<%= tabHomepage.ClientID %>',
            windowThemeRoller: '<%= windowThemeRoller.ClientID %>'
        };
    </script>

    <script src="res/js/index.js"></script>
    <script src="res/js/mobileview.js"></script>

</body>
</html>
