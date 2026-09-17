using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Entity;
using System.Linq;
using FineUI.Pro;

namespace FineUI.Pro.AppBox.admin
{
    public partial class user_changepassword : PageBase
    {
        #region ViewPower

        /// <summary>
        /// 本页面的浏览权限，空字符串表示本页面不受权限控制
        /// </summary>
        public override string ViewPower
        {
            get
            {
                return "CoreUserChangePassword";
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
            User current = DB.Users.Find(id);
            if (current == null)
            {
                // 参数错误，首先弹出Alert对话框然后关闭弹出窗口
                Alert.Show("参数错误！", String.Empty, ActiveWindow.GetHideReference());
                return;
            }

            if (current.Name == "admin" && GetIdentityName() != "admin")
            {
                Alert.Show("你无权编辑超级管理员！", String.Empty, ActiveWindow.GetHideReference());
                return;
            }

            labUserName.Text = current.Name;
            labUserRealName.Text = current.ChineseName;
        }

        #endregion

        #region Events

        protected void btnSaveClose_Click(object sender, EventArgs e)
        {
            int id = GetQueryIntValue("id");
            string newPass = tbxNewPassword.Text.Trim();
            string confirmNewPass = tbxConfirmPassword.Text.Trim();

            if (newPass != confirmNewPass)
            {
                tbxConfirmPassword.MarkInvalid("确认密码和新密码不一致！");
                return;
            }

            User current = DB.Users.Find(id);
            if (current != null)
            {
                current.Password = PasswordUtil.CreateDbPassword(tbxNewPassword.Text.Trim());
                DB.SaveChanges();
            }

            //Alert.Show("保存成功！", String.Empty, Alert.DefaultIcon, ActiveWindow.GetHidePostBackReference());
            // 关闭本窗体（触发窗体的关闭事件）
            ActiveWindow.HidePostBack();
        }
        #endregion

    }
}
