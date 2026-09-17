<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="role_power.aspx.cs" Inherits="FineUI.Pro.AppBox.admin.role_power" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title></title>
    <style>
        ul.powers {
            margin: 0;
            padding: 0;
        }

            ul.powers li {
                margin: 5px 15px 5px 0;
                display: inline-block;
                min-width: 150px;
            }

                ul.powers li input {
                    vertical-align: middle;
                }

                ul.powers li label {
                    margin-left: 5px;
                }

        /* 自动换行，权限复选框列表过长 */
        .f-grid-row .f-grid-cell-text {
            white-space: normal;
        }
    </style>
</head>
<body class="f-body-darkerbg">
    <form id="form1" runat="server">
        <f:PageManager ID="PageManager1" runat="server"></f:PageManager>
        <f:RegionPanel ID="RegionPanel1" ShowBorder="false" runat="server" IsViewPort="true" Margin="20px">
            <Regions>
                <f:Region ID="Region1" ShowBorder="false" ShowHeader="false" Width="260" RegionPosition="Left" RegionSplit="true" RegionSplitIcon="false" RegionSplitWidth="10" Layout="Fit" runat="server">
                    <Items>
                        <f:Grid ID="Grid1" runat="server" ShowBorder="true" ShowBorderShadow="true" ShowHeader="false" EnableCheckBoxSelect="false"
                            DataIDField="ID"
                            AllowSorting="true" OnSort="Grid1_Sort" SortField="Name" SortDirection="DESC"
                            AllowPaging="false"
                            EnableMultiSelect="false" OnRowClick="Grid1_RowClick" EnableRowClickEvent="true">
                            <Columns>
                                <f:RowNumberField></f:RowNumberField>
                                <f:BoundField DataField="Name" SortField="Name" ExpandUnusedSpace="true" HeaderText="角色名称"></f:BoundField>
                            </Columns>
                        </f:Grid>
                    </Items>
                </f:Region>
                <f:Region ID="Region2" ShowBorder="false" ShowHeader="false" RegionPosition="Center" Layout="Fit" runat="server">
                    <Items>
                        <f:Grid ID="Grid2" runat="server" ShowBorder="true" ShowBorderShadow="true" ShowHeader="false" EnableMultiSelect="true" EnableCheckBoxSelect="false" DataKeyNames="ModuleId,ModuleName" AllowSorting="true" OnSort="Grid2_Sort" OnRowDataBound="Grid2_RowDataBound" SortField="GroupName" SortDirection="DESC" AllowPaging="false">
                            <Toolbars>
                                <f:Toolbar ID="Toolbar1" runat="server">
                                    <Items>
                                        <f:Button ID="btnSelectAll" runat="server" Text="全选">
                                        </f:Button>
                                        <f:Button ID="btnUnSelectAll" runat="server" Text="反选">
                                        </f:Button>
                                        <f:ToolbarSeparator runat="server"></f:ToolbarSeparator>
                                        <f:Button ID="btnGroupUpdate" ButtonColor="Primary" Icon="GroupEdit" runat="server" Text="更新当前角色的权限" OnClick="btnGroupUpdate_Click">
                                        </f:Button>
                                    </Items>
                                </f:Toolbar>
                            </Toolbars>
                            <Columns>
                                <f:RowNumberField></f:RowNumberField>
                                <f:BoundField DataField="GroupName" SortField="GroupName" HeaderText="分组名称" Width="120px"></f:BoundField>
                                <f:TemplateField ExpandUnusedSpace="true" ColumnID="Powers" HeaderText="权限列表">
                                    <ItemTemplate>
                                        <asp:CheckBoxList ID="ddlPowers" CssClass="powers" RepeatLayout="UnorderedList" RepeatDirection="Vertical" runat="server">
                                        </asp:CheckBoxList>
                                    </ItemTemplate>
                                </f:TemplateField>
                            </Columns>
                        </f:Grid>
                    </Items>
                </f:Region>
            </Regions>
        </f:RegionPanel>
        <f:Menu ID="Menu2" runat="server">
            <f:MenuButton ID="menuSelectRows" runat="server" Text="全选行">
            </f:MenuButton>
            <f:MenuButton ID="menuUnselectRows" runat="server" Text="取消行">
            </f:MenuButton>
        </f:Menu>
    </form>
    <script>
        var grid2ID = '<%= Grid2.ClientID %>';
        var btnSelectAll = '<%= btnSelectAll.ClientID %>';
        var btnUnSelectAll = '<%= btnUnSelectAll.ClientID %>';

        var menuID = '<%= Menu2.ClientID %>';
        var menuSelectRows = '<%= menuSelectRows.ClientID %>';
        var menuUnselectRows = '<%= menuUnselectRows.ClientID %>';


        F.ready(function () {
            var grid = F(grid2ID), gridEl = grid.el; //$(grid.el.dom);
            var checkboxSelector = '.powers input[type=checkbox]',
                selectedRowSelector = '.f-grid-row-selected',
                selectedRowCheckboxSelector = selectedRowSelector + ' ' + checkboxSelector;


            F(grid2ID).on('beforerowcontextmenu', function (event, rowId, rowIndex) {
                F(menuID).show();
                // 返回 false 后，Grid 会调用 event.preventDefault()，阻止浏览器默认右键菜单，只显示上面的自定义菜单。
                return false;
            });


            function selectCheckbox(checked) {
                var selectedRows = gridEl.find(selectedRowSelector);
                if (selectedRows.length) {
                    gridEl.find(selectedRowCheckboxSelector).prop('checked', checked);
                } else {
                    gridEl.find(checkboxSelector).prop('checked', checked);
                }
            }

            F(menuSelectRows).on('click', function () {
                selectCheckbox(true);
            });

            F(menuUnselectRows).on('click', function () {
                selectCheckbox(false);
            });


            F(btnSelectAll).on('click', function () {
                selectCheckbox(true);
            });
            F(btnUnSelectAll).on('click', function () {
                selectCheckbox(false);
            });

        });

    </script>
</body>
</html>
