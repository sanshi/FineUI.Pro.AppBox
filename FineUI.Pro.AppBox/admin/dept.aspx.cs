
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
    public partial class dept : PageBase
    {
        #region ViewPower

        /// <summary>
        /// 本页面的浏览权限，空字符串表示本页面不受权限控制
        /// </summary>
        public override string ViewPower
        {
            get
            {
                return "CoreDeptView";
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
            var powerCoreDeptNew = CheckPower("CoreDeptNew");
            var powerCoreDeptEdit = CheckPower("CoreDeptEdit");
            var powerCoreDeptDelete = CheckPower("CoreDeptDelete");

            // 根据用户权限控制页面控件的可用状态
            btnNew.Enabled = powerCoreDeptNew;

            // 行内编辑按钮的权限
            Grid1.FindColumn("editField").Enabled = powerCoreDeptEdit;
            // 行内删除按钮的权限
            Grid1.FindColumn("deleteField").Enabled = powerCoreDeptDelete;



            BindGrid();
        }

        private void BindGrid()
        {
            Grid1.DataSource = DB.Depts.OrderBy(d => d.SortIndex).ToList();
            Grid1.DataBind();
        }

        #endregion

        #region Events

        protected void Grid1_RowCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                // 删除行
                var rowID = Convert.ToInt32(e.RowID);

                // 在操作之前进行权限检查
                if (!CheckPower("CoreDeptDelete"))
                {
                    CheckPowerFailWithAlert();
                    return;
                }

                int userCount = DB.Users.Where(u => u.DeptID == rowID).Count();
                if (userCount > 0)
                {
                    Alert.ShowInTop("删除失败！需要先清空属于此部门的用户！");
                    return;
                }

                int childCount = DB.Depts.Where(d => d.Parent.ID == rowID).Count();
                if (childCount > 0)
                {
                    Alert.ShowInTop("删除失败！请先删除子部门！");
                    return;
                }

                DB.Depts.Where(d => d.ID == rowID).Delete();


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
