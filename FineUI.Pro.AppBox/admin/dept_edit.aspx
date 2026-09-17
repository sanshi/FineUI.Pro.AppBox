<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dept_edit.aspx.cs" Inherits="FineUI.Pro.AppBox.admin.dept_edit" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title></title>
</head>
<body class="f-body-darkerbg">
    <form id="form1" runat="server">
        <f:PageManager ID="PageManager1" runat="server" />
        <f:Panel ID="Panel1" ShowBorder="false" ShowHeader="false" IsViewPort="true" BodyPadding="10" Layout="Fit" runat="server">
            <Toolbars>
                <f:Toolbar ID="Toolbar1" runat="server">
                    <Items>
                        <f:Button ID="btnClose" Icon="SystemClose" runat="server" ClickHandler="onCloseActiveWindowClick" Text="关闭">
                        </f:Button>
                        <f:ToolbarSeparator runat="server"></f:ToolbarSeparator>
                        <f:Button ID="btnSaveClose" ValidateForms="SimpleForm1" Icon="SystemSaveClose"
                            OnClick="btnSaveClose_Click" runat="server" Text="保存后关闭">
                        </f:Button>
                    </Items>
                </f:Toolbar>
            </Toolbars>
            <Items>
                <f:SimpleForm ID="SimpleForm1" ShowBorder="true" ShowBorderShadow="true" ShowHeader="false" BodyPadding="10" AutoScroll="true" runat="server">
                    <Items>
                        <f:TextBox ID="tbxName" runat="server" Label="名称" Required="true" ShowRedStar="true">
                        </f:TextBox>
                        <f:NumberBox ID="tbxSortIndex" Label="排序" Required="true" ShowRedStar="true" runat="server">
                        </f:NumberBox>
                        <f:DropDownBox ID="ddbParent" Label="上级部门" AutoShowClearIcon="true" runat="server">
                            <PopPanel>
                                <f:Grid ID="Grid1" ShowBorder="true" ShowHeader="false" Hidden="true" Width="550" ShowGridHeader="false"
                                    DataIDField="ID" DataTextField="Name"
                                    EnableTree="true" TreeColumn="Name" DataParentIDField="ParentID" 
                                    ExpandAllTreeNodes="true" DisableUnselectableRows="true"
                                    EnableRowLines="false" EnableAlternateRowColor="false"
                                    OnRowDataBound="Grid1_RowDataBound" runat="server">
                                    <Columns>
                                        <f:RenderField ColumnID="Name" DataField="Name" HeaderText="部门名称" ExpandUnusedSpace="true" />
                                    </Columns>
                                </f:Grid>
                            </PopPanel>
                        </f:DropDownBox>
                        <f:TextArea ID="tbxRemark" runat="server" Label="备注">
                        </f:TextArea>
                    </Items>
                </f:SimpleForm>
            </Items>
        </f:Panel>
    </form>
</body>
</html>
