using FineUI.Pro;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FineUI.Pro.AppBox.admin
{
    public partial class dept_user_addnew : PageBase
    {
        #region ViewPower

        /// <summary>
        /// 本页面的浏览权限，空字符串表示本页面不受权限控制
        /// </summary>
        public override string ViewPower
        {
            get
            {
                return "CoreDeptUserNew";
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

        private void LoadData()
        {

            int id = GetQueryIntValue("id");
            Dept current = DB.Depts.Find(id);
            if (current == null)
            {
                // 参数错误，首先弹出Alert对话框然后关闭弹出窗口
                Alert.Show("参数错误！", String.Empty, ActiveWindow.GetHideReference());
                return;
            }

            // 每页记录数
            Grid1.PageSize = ConfigHelper.PageSize;
            ddlGridPageSize.SelectedValue = ConfigHelper.PageSize.ToString();


            BindGrid();
        }


        private void BindGrid()
        {
            IQueryable<User> q = DB.Users.Include(u => u.Dept);

            // 在职称名称中搜索
            string searchText = ttbSearchMessage.Text?.Trim();
            if (!String.IsNullOrEmpty(searchText))
            {
                q = q.Where(u => u.Name.Contains(searchText) || u.ChineseName.Contains(searchText) || u.EnglishName.Contains(searchText));
            }

            q = q.Where(u => u.Name != "admin");

            // 排除所有已经属于某个部门的用户
            q = q.Where(u => u.Dept == null);

            // 在查询添加之后，排序和分页之前获取总记录数
            Grid1.RecordCount = q.Count();

            // 排列和分页
            var users = q.SortAndPage(Grid1);


            Grid1.DataSource = users;
            Grid1.DataBind();

        }

        #endregion

        #region Events

        protected void btnSaveClose_Click(object sender, EventArgs e)
        {
            int deptID = GetQueryIntValue("id");

            // 选中的用户ID列表（跨页保持选中行）
            var selectedRowIDs = Grid1.SelectedRowIDArray.Select(u => Convert.ToInt32(u)).ToArray();
            if (selectedRowIDs.Length == 0)
            {
                Alert.Show("请至少选择一项！");
                return;
            }

            var users = DB.Users
                 .Where(u => selectedRowIDs.Contains(u.ID))
                 .ToList();

            users.ForEach(u => u.DeptID = deptID);

            DB.SaveChanges();

            

            // 关闭本窗体（触发窗体的关闭事件）
            ActiveWindow.HidePostBack();
        }



        protected void ttbSearchMessage_Trigger2Click(object sender, EventArgs e)
        {
            ttbSearchMessage.ShowTrigger1 = true;
            BindGrid();
        }

        protected void ttbSearchMessage_Trigger1Click(object sender, EventArgs e)
        {
            ttbSearchMessage.Text = String.Empty;
            ttbSearchMessage.ShowTrigger1 = false;
            BindGrid();
        }

        protected void Grid1_Sort(object sender, GridSortEventArgs e)
        {
            BindGrid();
        }

        protected void Grid1_PageIndexChange(object sender, GridPageEventArgs e)
        {
            BindGrid();
        }


        protected void ddlGridPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            Grid1.PageSize = Convert.ToInt32(ddlGridPageSize.SelectedValue);

            BindGrid();
        }

        #endregion


    }
}
