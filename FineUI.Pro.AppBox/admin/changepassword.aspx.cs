using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using FineUI.Pro;
using System.Linq;

namespace FineUI.Pro.AppBox.admin
{
    public partial class changepassword : PageBase
    {
        #region ViewPower

        /// <summary>
        /// 本页面的浏览权限，空字符串表示本页面不受权限控制
        /// </summary>
        public override string ViewPower
        {
            get
            {
                return "";
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

        protected void btnSave_OnClick(object sender, EventArgs e)
        {
            int? id = GetIdentityID();

            string oldPass = tbxOldPassword.Text.Trim();
            string newPass = tbxNewPassword.Text.Trim();
            string confirmNewPass = tbxConfirmNewPassword.Text.Trim();

            if (newPass != confirmNewPass)
            {
                tbxConfirmNewPassword.MarkInvalid("确认密码和新密码不一致！");
                return;
            }

            User current = DB.Users.Where(u => u.ID == id.Value).FirstOrDefault();

            if (current != null)
            {
                if (!PasswordUtil.ComparePasswords(current.Password, oldPass))
                {
                    tbxOldPassword.MarkInvalid("当前密码不正确！");
                    return;
                }

                current.Password = PasswordUtil.CreateDbPassword(newPass);
                DB.SaveChanges();

                Alert.ShowInTop("修改密码成功！");
            }
        }

        #endregion

    }
}
