<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="FineUI.Pro.AppBox.main" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>首页</title>
    <link href="res/css/index.css" rel="stylesheet" />
    <link href="res/css/appbox.css" rel="stylesheet" />
    <link href="res/css/mobileview.css" rel="stylesheet" />

    <style type="text/css">
        /* 侧边栏宽度：res/js/index.js 从这两个变量读初始宽度与折叠后的微型宽度，
           必须与侧栏区域上的 Width 属性保持一致（两处都改，否则初始宽度和拖动宽度会打架）。 */
        :root {
            --sidebar-width: 320px;
            --sidebar-minimode-width: 70px;
        }
    </style>
</head>
<body class="f-body-darkerbg">
    <form id="form1" runat="server">
        <f:PageManager ID="PageManager1" runat="server"></f:PageManager>
        <f:Panel ID="mainPanel" Layout="Region" CssClass="mainpanel" ShowBorder="false" ShowHeader="false" IsViewPort="true" runat="server">
            <Items>
                <f:Panel ID="sidebarRegion" CssClass="sidebarregion" RegionPosition="Left" ShowBorder="false" Width="320" ShowHeader="false"
                    EnableCollapse="false" Collapsed="false" Layout="VBox" runat="server"
                    RegionSplit="true" RegionSplitIcon="false" RegionSplitWidth="3" RegionSplitTransparent="true">
                    <Items>
                        <f:ContentPanel CssClass="topregion" ShowBorder="false" ShowHeader="false" runat="server">
                            <div id="sideheader" class="f-widget-header f-mainheader">
                                <a class="logo-img f-widget-header" href="./">
                                    <svg version="1.1" xmlns="http://www.w3.org/2000/svg" width="512" height="512" viewBox="0 0 512 512">
                                        <path fill="currentColor" opacity="0.9" fill-rule="evenodd"
                                            d="M498.526 215.579h-4.58c-22.829-0.196-42.295-14.382-50.262-34.394l-0.13-0.369-1.617-4.042c-2.978-6.535-4.714-14.172-4.714-22.214 0-14.908 5.964-28.424 15.636-38.291l3.225-3.225c2.421-2.436 3.918-5.792 3.918-9.499s-1.497-7.064-3.919-9.5l0 0.001-38.4-38.13c-2.436-2.421-5.792-3.919-9.5-3.919s-7.063 1.497-9.5 3.919l-3.233 3.233c-9.859 9.663-23.373 15.627-38.282 15.627-8.043 0-15.68-1.736-22.558-4.853l0.344 0.14-4.043-1.617c-20.268-8.177-34.341-27.621-34.492-50.373v-4.6c0-7.441-6.032-13.473-13.474-13.473v0h-53.894c-7.441 0-13.474 6.032-13.474 13.473v0 4.58c-0.196 22.828-14.382 42.295-34.394 50.262l-0.369 0.129-4.042 1.617c-6.535 2.978-14.172 4.713-22.214 4.713-14.908 0-28.424-5.964-38.291-15.636l-3.225-3.225c-2.436-2.421-5.792-3.919-9.499-3.919s-7.064 1.497-9.5 3.919l0.001-0.001-38.13 38.4c-2.421 2.436-3.919 5.792-3.919 9.499s1.497 7.064 3.919 9.5l3.233 3.233c9.663 9.859 15.627 23.373 15.627 38.282 0 8.043-1.736 15.68-4.853 22.559l0.14-0.344-1.617 4.042c-8.177 20.268-27.621 34.341-50.373 34.492h-4.6c-7.441 0-13.473 6.032-13.473 13.474v0 53.894c0 7.442 6.032 13.474 13.473 13.474v0h4.58c22.828 0.197 42.295 14.382 50.262 34.394l0.129 0.369 1.617 4.043c2.978 6.534 4.713 14.172 4.713 22.214 0 14.908-5.964 28.425-15.636 38.291l-3.225 3.225c-2.421 2.436-3.919 5.792-3.919 9.5s1.497 7.063 3.919 9.5l-0.001-0 38.4 38.13c2.436 2.421 5.792 3.918 9.499 3.918s7.064-1.497 9.5-3.919l3.233-3.233c9.859-9.663 23.373-15.627 38.282-15.627 8.043 0 15.68 1.736 22.559 4.853l-0.344-0.14 4.042 1.617c20.268 8.177 34.341 27.622 34.492 50.373v4.6c0 7.442 6.032 13.474 13.474 13.474h53.894c7.442 0 13.474-6.032 13.474-13.474v0-4.58c0.197-22.829 14.382-42.295 34.394-50.262l0.369-0.13 4.043-1.617c6.534-2.978 14.172-4.714 22.214-4.714 14.908 0 28.425 5.964 38.291 15.636l3.225 3.225c2.436 2.421 5.792 3.918 9.5 3.918s7.063-1.497 9.5-3.919l-0 0 38.13-38.4c2.421-2.436 3.918-5.792 3.918-9.5s-1.497-7.063-3.919-9.5l-3.233-3.233c-9.663-9.859-15.627-23.373-15.627-38.282 0-8.043 1.736-15.68 4.853-22.558l-0.14 0.344 1.617-4.043c8.177-20.268 27.622-34.341 50.373-34.492h4.6c7.442 0 13.473-6.032 13.473-13.474v0-53.894c0-7.441-6.032-13.474-13.474-13.474v0z M256 107.79c81.854 0 148.21 66.356 148.21 148.21s-66.356 148.21-148.21 148.21S107.79 337.854 107.79 256 174.146 107.79 256 107.79z">
                                        </path>
                                        <path fill="currentColor" opacity="0.6" fill-rule="evenodd"
                                            d="M256.002 107.79c-81.854 0-148.21 66.356-148.21 148.21s66.356 148.21 148.21 148.21c81.854 0 148.21-66.356 148.21-148.21v0c0-81.854-66.356-148.21-148.21-148.21v0z M256.002 323.369c-37.206 0-67.369-30.161-67.369-67.369s30.161-67.369 67.369-67.369c37.206 0 67.369 30.161 67.369 67.369v0c0 37.206-30.161 67.369-67.369 67.369v0z">
                                        </path>
                                    </svg>
                                </a>
                                <a class="logo" href="./" title="FineUI.Pro.AppBox" id="logoTitle" runat="server">FineUI.Pro</a>
                                <div class="logo-subtitle">AppBox · EF</div>
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
    <script src="res/js/index-appbox.js"></script>
    <script src="res/js/mobileview.js"></script>

</body>
</html>
