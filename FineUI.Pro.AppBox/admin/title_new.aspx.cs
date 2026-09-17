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
    public partial class title_new : PageBase
    {
        #region ViewPower

        /// <summary>
        /// 本页面的浏览权限，空字符串表示本页面不受权限控制
        /// </summary>
        public override string ViewPower
        {
            get
            {
                return "CoreTitleNew";
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

        }

        #endregion

        #region Events

        private void SaveJobTitle()
        {
            Title item = new Title();
            item.Name = tbxName.Text.Trim();
            item.Remark = tbxRemark.Text.Trim();

            DB.Titles.Add(item);
            DB.SaveChanges();
        }

        protected void btnSaveClose_Click(object sender, EventArgs e)
        {
            SaveJobTitle();

            //Alert.Show("添加成功！", String.Empty, ActiveWindow.GetHidePostBackReference());
            // 关闭本窗体（触发窗体的关闭事件）
            ActiveWindow.HidePostBack();
        }
        #endregion

    }
}
