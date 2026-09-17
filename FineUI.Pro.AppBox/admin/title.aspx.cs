using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;
using System.Data.Entity;
using FineUI.Pro;
using EntityFramework.Extensions;

namespace FineUI.Pro.AppBox.admin
{
    public partial class title : PageBase
    {
        #region ViewPower

        /// <summary>
        /// 本页面的浏览权限，空字符串表示本页面不受权限控制
        /// </summary>
        public override string ViewPower
        {
            get
            {
                return "CoreTitleView";
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
            var powerCoreTitleNew = CheckPower("CoreTitleNew");
            var powerCoreTitleEdit = CheckPower("CoreTitleEdit");
            var powerCoreTitleDelete = CheckPower("CoreTitleDelete");

            // 根据用户权限控制页面控件的可用状态
            btnNew.Enabled = powerCoreTitleNew;

            // 行内编辑按钮的权限
            Grid1.FindColumn("editField").Enabled = powerCoreTitleEdit;
            // 行内删除按钮的权限
            Grid1.FindColumn("deleteField").Enabled = powerCoreTitleDelete;



            // 每页记录数
            Grid1.PageSize = ConfigHelper.PageSize;

            BindGrid();
        }

        private void BindGrid()
        {
            IQueryable<Title> q = DB.Titles;

            // 在职称名称中搜索
            string searchText = ttbSearchMessage.Text?.Trim();
            if (!String.IsNullOrEmpty(searchText))
            {
                q = q.Where(t => t.Name.Contains(searchText));
            }

            // 在查询添加之后，排序和分页之前获取总记录数
            Grid1.RecordCount = q.Count();

            // 排列和分页
            var titles = q.SortAndPage(Grid1);

            Grid1.DataSource = titles;
            Grid1.DataBind();
        }

        #endregion

        #region Events

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

        protected void Grid1_RowCommand(object sender, GridCommandEventArgs e)
        {
            int titleID = Convert.ToInt32(Grid1.SelectedRowID);

            if (e.CommandName == "Delete")
            {
                // 在操作之前进行权限检查
                if (!CheckPower("CoreTitleDelete"))
                {
                    CheckPowerFailWithAlert();
                    return;
                }

                int userCount = DB.Users.Where(u => u.Titles.Any(t => t.ID == titleID)).Count();
                if (userCount > 0)
                {
                    Alert.ShowInTop("删除失败！需要先清空拥有此职称的用户！");
                    return;
                }

                DB.Titles.Where(t => t.ID == titleID).Delete();

                BindGrid();
            }
        }

        protected void Window1_Close(object sender, EventArgs e)
        {
            BindGrid();
        }

        #endregion

    }
}
