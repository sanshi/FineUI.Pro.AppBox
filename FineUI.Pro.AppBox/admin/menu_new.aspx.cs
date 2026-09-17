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
    public partial class menu_new : PageBase
    {
        #region ViewPower

        /// <summary>
        /// 本页面的浏览权限，空字符串表示本页面不受权限控制
        /// </summary>
        public override string ViewPower
        {
            get
            {
                return "CoreMenuNew";
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

            //// 模块名称列表
            //ddlModules.DataSource = ModuleTypeHelper.GetAppModules();
            //ddlModules.DataBind();

            //ddlModules.SelectedValue = ModuleTypeHelper.Module2String(ModuleType.None);

            // 绑定下拉树表格
            BindParentDDB();

            InitIconList(iconList);
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
        }

        #endregion

        #region Events

        private void SaveItem()
        {
            Menu item = new Menu();
            item.Name = tbxName.Text.Trim();
            item.NavigateUrl = tbxUrl.Text.Trim();
            item.SortIndex = Convert.ToInt32(tbxSortIndex.Text.Trim());
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

            DB.Menus.Add(item);
            DB.SaveChanges();

        }

        protected void btnSaveClose_Click(object sender, EventArgs e)
        {
            SaveItem();

            //Alert.Show("添加成功！", String.Empty, ActiveWindow.GetHidePostBackReference());
            // 关闭本窗体（触发窗体的关闭事件）
            ActiveWindow.HidePostBack();
        }

        #endregion

    }
}
