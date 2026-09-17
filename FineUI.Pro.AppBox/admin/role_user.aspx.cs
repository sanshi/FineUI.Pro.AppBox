using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;
using System.Data.Entity;
using FineUI.Pro;
using Newtonsoft.Json.Linq;
using EntityFramework.Extensions;

namespace FineUI.Pro.AppBox.admin
{
    public partial class role_user : PageBase
    {
        #region ViewPower

        /// <summary>
        /// 本页面的浏览权限，空字符串表示本页面不受权限控制
        /// </summary>
        public override string ViewPower
        {
            get
            {
                return "CoreRoleUserView";
            }
        }

        #endregion

        #region Page_Load

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        protected void Page_CustomEvent(object sender, CustomEventArgs e)
        {
            if (e.EventName == "Grid2_DeleteRows")
            {
                int[] rowIDs = e.EventArgumentsAsJObject.Value<JArray>("rowIDs").ToObject<int[]>();
                DeleteRows(rowIDs);
            }
        }

        private void LoadData()
        {
            var powerCoreRoleUserNew = CheckPower("CoreRoleUserNew");
            var powerCoreRoleUserDelete = CheckPower("CoreRoleUserDelete");

            // 根据用户权限控制页面控件的可用状态
            btnNew.Enabled = powerCoreRoleUserNew;
            btnDeleteSelected.Enabled = powerCoreRoleUserDelete;

            // 行内删除按钮的权限
            Grid2.FindColumn("deleteField").Enabled = powerCoreRoleUserDelete;




            BindGrid1();

            // 默认选中第一个角色
            GridSelectionUtil.SelectFirstRow(Grid1);

            // 每页记录数
            Grid2.PageSize = ConfigHelper.PageSize;
            ddlGridPageSize.SelectedValue = ConfigHelper.PageSize.ToString();

            BindGrid2();
        }

        private void BindGrid1()
        {
            IQueryable<Role> q = DB.Roles;

            // 排列
            var roles = q.Sort(Grid1);

            Grid1.DataSource = roles;
            Grid1.DataBind();
        }

        private void BindGrid2()
        {
            // 左侧表格选中的行
            if (String.IsNullOrEmpty(Grid1.SelectedRowID))
            {
                Grid2.DataSource = null;
                Grid2.DataBind();

                return;
            }

            var roleID = Convert.ToInt32(Grid1.SelectedRowID);

            IQueryable<User> q = DB.Users;

            // 在用户名称中搜索
            string searchText = ttbSearchMessage.Text?.Trim();
            if (!String.IsNullOrEmpty(searchText))
            {
                q = q.Where(u => u.Name.Contains(searchText) || u.ChineseName.Contains(searchText) || u.EnglishName.Contains(searchText));
            }

            q = q.Where(u => u.Name != "admin");

            // 过滤选中角色下的所有用户
            q = q.Where(u => u.Roles.Any(r => r.ID == roleID));

            // 在查询添加之后，排序和分页之前获取总记录数
            Grid2.RecordCount = q.Count();

            // 排列和分页
            var users = q.SortAndPage(Grid2);

            Grid2.DataSource = users;
            Grid2.DataBind();


        }

        #endregion

        #region Events

        protected void ddlGridPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            Grid2.PageSize = Convert.ToInt32(ddlGridPageSize.SelectedValue);

            BindGrid2();
        }


        #endregion

        #region Grid1 Events

        protected void Grid1_Sort(object sender, GridSortEventArgs e)
        {
            BindGrid1();

            // 默认选中第一个角色
            GridSelectionUtil.SelectFirstRow(Grid1);

            BindGrid2();
        }

        protected void Grid1_RowClick(object sender, FineUI.Pro.GridRowClickEventArgs e)
        {
            BindGrid2();
        }

        #endregion

        #region Grid2 Events

        protected void ttbSearchMessage_Trigger2Click(object sender, EventArgs e)
        {
            ttbSearchMessage.ShowTrigger1 = true;
            BindGrid2();
        }

        protected void ttbSearchMessage_Trigger1Click(object sender, EventArgs e)
        {
            ttbSearchMessage.Text = String.Empty;
            ttbSearchMessage.ShowTrigger1 = false;
            BindGrid2();
        }

        protected void Grid2_Sort(object sender, GridSortEventArgs e)
        {
            BindGrid2();
        }

        protected void Grid2_PageIndexChange(object sender, GridPageEventArgs e)
        {
            BindGrid2();
        }


        protected void Grid2_RowCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                var rowID = Convert.ToInt32(e.RowID);

                DeleteRows(new int[] { rowID });

            }
        }




        protected void Window1_Close(object sender, EventArgs e)
        {
            BindGrid2();
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            int roleID = Convert.ToInt32(Grid1.SelectedRowID);
            string addUrl = String.Format("~/admin/role_user_addnew.aspx?id={0}", roleID);

            PageContext.RegisterStartupScript(Window1.GetShowReference(addUrl, "添加用户到当前角色"));
        }

        #endregion


        #region DeleteRows

        private void DeleteRows(int[] rowIDs)
        {
            // 左侧表格选中的行
            if (String.IsNullOrEmpty(Grid1.SelectedRowID))
            {
                return;
            }

            var roleID = Convert.ToInt32(Grid1.SelectedRowID);


            // 在操作之前进行权限检查
            if (!CheckPower("CoreRoleUserDelete"))
            {
                CheckPowerFailWithAlert();
                return;
            }


            Role role = DB.Roles
                .Include(r => r.Users)
                .Where(r => r.ID == roleID)
                .FirstOrDefault();

            var users = role.Users.Where(u => rowIDs.Contains(u.ID)).ToList();

            users.ForEach(u => role.Users.Remove(u));


            DB.SaveChanges();

            // 重新绑定表格
            BindGrid2();
        }



        #endregion
    }
}
