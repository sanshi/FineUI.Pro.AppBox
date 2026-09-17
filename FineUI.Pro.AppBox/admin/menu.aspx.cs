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
    public partial class menu : PageBase
    {
        #region ViewPower

        /// <summary>
        /// 本页面的浏览权限，空字符串表示本页面不受权限控制
        /// </summary>
        public override string ViewPower
        {
            get
            {
                return "CoreMenuView";
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
            var powerCoreMenuNew = CheckPower("CoreMenuNew");
            var powerCoreMenuEdit = CheckPower("CoreMenuEdit");
            var powerCoreMenuDelete = CheckPower("CoreMenuDelete");

            // 根据用户权限控制页面控件的可用状态
            btnNew.Enabled = powerCoreMenuNew;

            // 行内编辑按钮的权限
            Grid1.FindColumn("editField").Enabled = powerCoreMenuEdit;
            // 行内删除按钮的权限
            Grid1.FindColumn("deleteField").Enabled = powerCoreMenuDelete;






            BindGrid();
        }

        private void BindGrid()
        {
            List<Menu> menus = DB.Menus.OrderBy(m => m.SortIndex).ToList();
            Grid1.DataSource = menus;
            Grid1.DataBind();
        }


        protected string GetModuleName(object moduleNameObj)
        {
            string moduleName = moduleNameObj.ToString();
            if (moduleName == "None")
            {
                return String.Empty;
            }
            return moduleName;
        }

        #endregion

        #region Events


        protected void Grid1_RowCommand(object sender, GridCommandEventArgs e)
        {
            int menuID = Convert.ToInt32(Grid1.SelectedRowID);

            if (e.CommandName == "Delete")
            {
                // 在操作之前进行权限检查
                if (!CheckPower("CoreMenuDelete"))
                {
                    CheckPowerFailWithAlert();
                    return;
                }

                int childCount = DB.Menus.Where(m => m.Parent.ID == menuID).Count();
                if (childCount > 0)
                {
                    Alert.ShowInTop("删除失败！请先删除子菜单！");
                    return;
                }

                DB.Menus.Where(m => m.ID == menuID).Delete();

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
