
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;
using System.Data.Entity;
using FineUI.Pro;
using Newtonsoft.Json.Linq;

namespace FineUI.Pro.AppBox.admin
{
    public partial class dept_user : PageBase
    {
        #region ViewPower

        /// <summary>
        /// 本页面的浏览权限，空字符串表示本页面不受权限控制
        /// </summary>
        public override string ViewPower
        {
            get
            {
                return "CoreDeptUserView";
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
            var powerCoreDeptUserNew = CheckPower("CoreDeptUserNew");
            var powerCoreDeptUserDelete = CheckPower("CoreDeptUserDelete");

            // 根据用户权限控制页面控件的可用状态
            btnNew.Enabled = powerCoreDeptUserNew;
            btnDeleteSelected.Enabled = powerCoreDeptUserDelete;

            // 行内删除按钮的权限
            Grid2.FindColumn("deleteField").Enabled = powerCoreDeptUserDelete;




            BindGrid1();

            // 默认选中第一个部门
            GridSelectionUtil.SelectFirstRow(Grid1);

            // 每页记录数
            Grid2.PageSize = ConfigHelper.PageSize;
            ddlGridPageSize.SelectedValue = ConfigHelper.PageSize.ToString();

            BindGrid2();
        }

        private void BindGrid1()
        {
            var depts = DB.Depts.OrderBy(d => d.SortIndex).ToList();

            Grid1.DataSource = depts;
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

            var deptID = Convert.ToInt32(Grid1.SelectedRowID);

            // 查询 X_User 表
            IQueryable<User> q = DB.Users.Include(u => u.Dept);

            // 在用户名称中搜索
            string searchText = ttbSearchMessage.Text?.Trim();
            if (!String.IsNullOrEmpty(searchText))
            {
                q.Where(u => u.Name.Contains(searchText) || u.ChineseName.Contains(searchText) || u.EnglishName.Contains(searchText));
            }

            q = q.Where(u => u.Name != "admin");

            // 过滤选中部门下的所有用户
            q = q.Where(u => u.DeptID == deptID);

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

                DeleteRows(new int[] { rowID } );
            }
        }

        protected void Window1_Close(object sender, EventArgs e)
        {
            BindGrid2();
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            int deptID = Convert.ToInt32(Grid1.SelectedRowID);
            string addUrl = String.Format("~/admin/dept_user_addnew.aspx?id={0}", deptID);

            PageContext.RegisterStartupScript(Window1.GetShowReference(addUrl, "添加用户到当前部门"));
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
            var deptID = Convert.ToInt32(Grid1.SelectedRowID);

            // 在操作之前进行权限检查
            if (!CheckPower("CoreDeptUserDelete"))
            {
                CheckPowerFailWithAlert();
                return;
            }

            // 方法一：直接删除用户与部门的关联
            var users = DB.Users.Include(u => u.Dept)
                .Where(u => rowIDs.Contains(u.ID))
                .ToList();
            users.ForEach(u => u.Dept = null);


            //// 方法二：通过部门删除用户的关联
            //Dept dept = DB.Depts
            //    .Include(r => r.Users)
            //    .Where(r => r.ID == deptID)
            //    .FirstOrDefault();
            //var users = dept.Users.Where(u => rowIDs.Contains(u.ID)).ToList();
            //users.ForEach(u => dept.Users.Remove(u));



            DB.SaveChanges();

            // 重新绑定表格
            BindGrid2();
        }

        #endregion

    }
}
