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
                <f:Region ID="Region1" ShowBorder="false" ShowHeader="false" Width="260" RegionPosition="Left" RegionSplit="true" RegionSplitIcon="false"
                    RegionSplitWidth="10" Layout="Fit" runat="server">
                    <Items>
                        <f:Grid ID="Grid1" runat="server" ShowBorder="true" ShowBorderShadow="true" ShowHeader="false" EnableCheckBoxSelect="false"
                            DataIDField="ID" AllowSorting="true" OnSort="Grid1_Sort" SortField="Name" SortDirection="DESC" AllowPaging="false"
                            EnableMultiSelect="false" OnRowClick="Grid1_RowClick" EnableRowClickEvent="true">
                            <Columns>
                                <f:RowNumberField></f:RowNumberField>
                                <f:RenderField DataField="Name" SortField="Name" ExpandUnusedSpace="true" HeaderText="角色名称" />
                            </Columns>
                        </f:Grid>
                    </Items>
                </f:Region>
                <f:Region ID="Region2" ShowBorder="false" ShowHeader="false" RegionPosition="Center" Layout="Fit" runat="server">
                    <Items>
                        <f:Grid ID="Grid2" runat="server" ShowBorder="true" ShowBorderShadow="true" ShowHeader="false" EnableMultiSelect="true"
                            EnableCheckBoxSelect="false" AllowSorting="true" OnSort="Grid2_Sort" SortField="GroupName" SortDirection="DESC" AllowPaging="false">
                            <Toolbars>
                                <f:Toolbar ID="Toolbar1" runat="server">
                                    <Items>
                                        <f:Button ID="btnSelectAll" runat="server" Text="全选">
                                        </f:Button>
                                        <f:Button ID="btnUnSelectAll" runat="server" Text="反选">
                                        </f:Button>
                                        <f:ToolbarSeparator runat="server"></f:ToolbarSeparator>
                                        <f:Button ID="btnGroupUpdate" ButtonColor="Primary" Icon="GroupEdit" runat="server" Text="更新当前角色的权限"
                                            ClickHandler="onSavePowersClick">
                                        </f:Button>
                                    </Items>
                                </f:Toolbar>
                            </Toolbars>
                            <Columns>
                                <f:RowNumberField></f:RowNumberField>
                                <f:RenderField DataField="GroupName" SortField="GroupName" HeaderText="分组名称" Width="120px" />
                                <f:RenderField ColumnID="Powers" DataField="Powers" HeaderText="权限列表" ExpandUnusedSpace="true"
                                    RendererFunction="renderPowers" />
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



        // 权限列表保留原始数据，在浏览器生成勾选项；名称和标题编码后再放入 HTML。
        function renderPowers(value, params) {
            // Pro 的通用列把数组保存为 JSON 字符串，例如 [{"id":1,"title":"浏览角色","selected":true}]。
            var powers = typeof value === 'string' ? JSON.parse(value) : value;
            var html = ['<ul class="powers">'];
            $.each(powers, function(index, power) {
                var powerId = parseInt(power.id, 10);
                var inputId = grid2ID + '_power_' + powerId;
                var checked = power.selected ? ' checked="checked"' : '';
                html.push('<li><span data-qtip="' + F.htmlEncode(power.name) + '">');
                html.push('<input type="checkbox" id="' + inputId + '" value="' + powerId + '"' + checked + '>');
                html.push('<label for="' + inputId + '">' + F.htmlEncode(power.title) + '</label>');
                html.push('</span></li>');
            });
            html.push('</ul>');
            return html.join('');
        }

        function onSavePowersClick(event) {
            var powerIDs = [];
            F(grid2ID).el.find('.powers input[type=checkbox]:checked').each(function() {
                powerIDs.push(parseInt(this.value, 10));
            });
            F.customEvent('Grid2_SavePowers', {
                powerIDs: powerIDs
            });
        }

        F.ready(function() {
            var grid = F(grid2ID),
                gridEl = grid.el; //$(grid.el.dom);
            var checkboxSelector = '.powers input[type=checkbox]',
                selectedRowSelector = '.f-grid-row-selected',
                selectedRowCheckboxSelector = selectedRowSelector + ' ' + checkboxSelector;


            F(grid2ID).on('beforerowcontextmenu', function(event, rowId, rowIndex) {
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

            F(menuSelectRows).on('click', function() {
                selectCheckbox(true);
            });

            F(menuUnselectRows).on('click', function() {
                selectCheckbox(false);
            });


            F(btnSelectAll).on('click', function() {
                selectCheckbox(true);
            });
            F(btnUnSelectAll).on('click', function() {
                selectCheckbox(false);
            });

        });

    </script>
</body>
</html>
