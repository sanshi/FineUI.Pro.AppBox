using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;
using System.Data.Entity;
using FineUI.Pro;

namespace FineUI.Pro.AppBox.admin
{
    public partial class menu_edit : PageBase
    {
        #region ViewPower

        /// <summary>
        /// 本页面的浏览权限，空字符串表示本页面不受权限控制
        /// </summary>
        public override string ViewPower
        {
            get
            {
                return "CoreMenuEdit";
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

        public Menu CurrentMenu { get; set; }

        private void LoadData()
        {

            int id = GetQueryIntValue("id");
            Menu current = DB.Menus
                .Include(m => m.Parent).Include(m => m.ViewPower)
                .Where(m => m.ID == id).FirstOrDefault();
            if (current == null)
            {
                // 参数错误，首先弹出Alert对话框然后关闭弹出窗口
                Alert.Show("参数错误！", String.Empty, ActiveWindow.GetHideReference());
                return;
            }

            // 将当前菜单保存到属性中，供后续在 Grid1_RowDataBound 中使用
            CurrentMenu = current;

            tbxName.Text = current.Name;
            tbxUrl.Text = current.NavigateUrl;
            tbxSortIndex.Text = current.SortIndex.ToString();
            tbxIcon.Text = current.ImageUrl;
            tbxRemark.Text = current.Remark;
            if (current.ViewPowerName != null)
            {
                tbxViewPower.Text = current.ViewPowerName;
            }


            // 绑定下拉树表格
            BindParentDDB();

            // 预置图标列表
            InitIconList(iconList);

            // 初始化图标列表的选中值
            if (!String.IsNullOrEmpty(current.ImageUrl))
            {
                iconList.SelectedValue = current.ImageUrl;
            }

        }

        public void InitIconList(FineUI.Pro.RadioButtonList iconList)
        {
            string[] icons = new string[] { "tag_yellow", "tag_red", "tag_purple", "tag_pink", "tag_orange", "tag_green", "tag_blue" };
            foreach (string icon in icons)
            {
                string value = String.Format("~/res/icon/{0}.png", icon);
                RadioItem item = new RadioItem
                {
                    Value = value,
                    TextRawHtml = new RawHtml(String.Format("<img style=\"vertical-align:bottom;\" src=\"{0}\" />&nbsp;{1}", ResolveUrl(value), icon))
                };

                iconList.Items.Add(item);
            }
        }


        private void BindParentDDB()
        {
            Grid1.DataSource = DB.Menus.OrderBy(m => m.SortIndex).ToList();
            Grid1.DataBind();

            if (CurrentMenu.Parent != null)
            {
                // 当前节点的父节点
                ddbParent.Value = CurrentMenu.ParentID.ToString();
                ddbParent.Text = CurrentMenu.Parent.Name;
            }
        }

        #endregion


        #region Grid1_RowDataBound

        protected void Grid1_RowDataBound(object sender, GridRowEventArgs e)
        {
            var menuID = Convert.ToInt32(e.RowID);

            // 如果此部门是当前部门（CurrentDept）或者当前部门的子项，则禁止选择
            if (IsOrChildOfCurrentModel(menuID))
            {
                e.RowSelectable = false;
            }
            else
            {
                e.RowSelectable = true;
            }
        }

        private bool IsOrChildOfCurrentModel(int menuID)
        {
            if (menuID == CurrentMenu.ID)
            {
                return true;
            }

            var menu = FindModelFromDataSource(menuID);
            if (menu.ParentID != null)
            {
                return IsOrChildOfCurrentModel(menu.ParentID.Value);
            }

            return false;
        }


        // 从表格的数据源中查找指定ID的部门对象
        private Menu FindModelFromDataSource(int menuID)
        {
            Menu result = null;
            var dataSource = Grid1.DataSource as List<Menu>;
            if (dataSource != null && dataSource.Count > 0)
            {
                result = dataSource.FirstOrDefault<Menu>(d => d.ID == menuID);
            }
            return result;
        }

        #endregion

        #region Events

        protected void btnSaveClose_Click(object sender, EventArgs e)
        {
            int id = GetQueryIntValue("id");
            Menu item = DB.Menus
                .Include(m => m.Parent).Include(m => m.ViewPower)
                .Where(m => m.ID == id).FirstOrDefault();
            item.Name = tbxName.Text.Trim();
            item.NavigateUrl = tbxUrl.Text.Trim();
            item.SortIndex = Convert.ToInt32(tbxSortIndex.Text.Trim());
            item.ImageUrl = tbxIcon.Text;
            item.Remark = tbxRemark.Text.Trim();


            // 设置父菜单
            if (!String.IsNullOrEmpty(ddbParent.Value))
            {
                int parentID = Convert.ToInt32(ddbParent.Value);
                item.ParentID = parentID;
            }
            else
            {
                item.ParentID = null;
            }

            string viewPowerName = tbxViewPower.Text.Trim();
            if (String.IsNullOrEmpty(viewPowerName))
            {
                item.ViewPower = null;
            }
            else
            {
                item.ViewPower = DB.Powers.Where(p => p.Name == viewPowerName).FirstOrDefault();
            }

            DB.SaveChanges();


            //FineUI.Pro.Alert.Show("保存成功！", String.Empty, FineUI.Pro.Alert.DefaultIcon, FineUI.Pro.ActiveWindow.GetHidePostBackReference());
            // 关闭本窗体（触发窗体的关闭事件）
            ActiveWindow.HidePostBack();
        }


        #endregion

    }
}
