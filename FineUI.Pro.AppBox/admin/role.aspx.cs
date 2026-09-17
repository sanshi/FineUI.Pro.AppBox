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
    public partial class role : PageBase
    {
        #region ViewPower

        /// <summary>
        /// 本页面的浏览权限，空字符串表示本页面不受权限控制
        /// </summary>
        public override string ViewPower
        {
            get
            {
                return "CoreRoleView";
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
            var powerCoreRoleNew = CheckPower("CoreRoleNew");
            var powerCoreRoleEdit = CheckPower("CoreRoleEdit");
            var powerCoreRoleDelete = CheckPower("CoreRoleDelete");

            // 根据用户权限控制页面控件的可用状态
            btnNew.Enabled = powerCoreRoleNew;

            // 行内编辑按钮的权限
            Grid1.FindColumn("editField").Enabled = powerCoreRoleEdit;
            // 行内删除按钮的权限
            Grid1.FindColumn("deleteField").Enabled = powerCoreRoleDelete;




            
            // 每页记录数
            Grid1.PageSize = ConfigHelper.PageSize;

            
            BindGrid();
        }

        private void BindGrid()
        {
            IQueryable<Role> q = DB.Roles;

            // 在名称中搜索
            string searchText = ttbSearchMessage.Text?.Trim();
            if (!String.IsNullOrEmpty(searchText))
            {
                q = q.Where(r => r.Name.Contains(searchText));
            }

            // 在查询添加之后，排序和分页之前获取总记录数
            Grid1.RecordCount = q.Count();

            // 排列和数据库分页
            var roles = q.SortAndPage(Grid1);

            Grid1.DataSource = roles;
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
            int roleID = Convert.ToInt32(Grid1.SelectedRowID);

            if (e.CommandName == "Delete")
            {
                // 在操作之前进行权限检查
                if (!CheckPower("CoreRoleDelete"))
                {
                    CheckPowerFailWithAlert();
                    return;
                }

                int userCountUnderThisRole = DB.Users.Where(u => u.Roles.Any(r => r.ID == roleID)).Count();
                
                if (userCountUnderThisRole > 0)
                {
                    Alert.ShowInTop("删除失败！需要先清空属于此角色的用户！");
                    return;
                }

                // 执行数据库操作
                DB.Roles.Where(r => r.ID == roleID).Delete();
                
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
