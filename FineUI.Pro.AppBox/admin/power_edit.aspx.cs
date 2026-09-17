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
    public partial class power_edit : PageBase
    {
        #region ViewPower

        /// <summary>
        /// 本页面的浏览权限，空字符串表示本页面不受权限控制
        /// </summary>
        public override string ViewPower
        {
            get
            {
                return "CorePowerEdit";
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
            Power current = DB.Powers.Find(id);
            if (current == null)
            {
                // 参数错误，首先弹出Alert对话框然后关闭弹出窗口
                Alert.Show("参数错误！", String.Empty, ActiveWindow.GetHideReference());
                return;
            }

            tbxName.Text = current.Name;
            tbxGroupName.Text = current.GroupName;
            tbxTitle.Text = current.Title;
            tbxRemark.Text = current.Remark;

        }


        #endregion

        #region Events

        protected void btnSaveClose_Click(object sender, EventArgs e)
        {
            int id = GetQueryIntValue("id");
            Power item = DB.Powers.Find(id);
            item.Name = tbxName.Text.Trim();
            item.GroupName = tbxGroupName.Text.Trim();
            item.Title = tbxTitle.Text.Trim();
            item.Remark = tbxRemark.Text.Trim();
            DB.SaveChanges();

            //FineUI.Pro.Alert.Show("保存成功！", String.Empty, FineUI.Pro.Alert.DefaultIcon, FineUI.Pro.ActiveWindow.GetHidePostBackReference());
            // 关闭本窗体（触发窗体的关闭事件）
            ActiveWindow.HidePostBack();
        }

        #endregion

    }
}
