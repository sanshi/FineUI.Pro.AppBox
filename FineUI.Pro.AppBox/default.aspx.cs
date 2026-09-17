using System;
using System.Web;
using System.Web.Security;

using FineUI.Pro;
using System.Text;
using System.Linq;


namespace FineUI.Pro.AppBox
{
    public partial class _default : PageBase
    {
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
            // 如果用户已经登录，则重定向到管理首页
            if (User.Identity.IsAuthenticated)
            {
                Response.Redirect(FormsAuthentication.DefaultUrl);
            }

            Window1.Title = String.Format("FineUI.Pro.AppBox v{0}", GetProductVersion());

        }

        #endregion

        #region Events

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string userName = tbxUserName.Text.Trim();
            string password = tbxPassword.Text.Trim();

            User user = DB.Users.Where(u => u.Name == userName).FirstOrDefault();

            if (user != null)
            {
                if (PasswordUtil.ComparePasswords(user.Password, password))
                {
                    if (!user.Enabled)
                    {
                        Alert.Show("用户未启用，请联系管理员！");
                    }
                    else
                    {
                        // 登录成功
                        LoginSuccess(user);
                    }
                }
                else
                {
                    Alert.Show("用户名或密码错误！");
                }

            }
            else
            {
                Alert.Show("用户名或密码错误！");
            }

        }


        private void LoginSuccess(User user)
        {
            RegisterOnlineUser(user);

            // 用户所属的角色字符串，以逗号分隔
            string roleIDs = String.Empty;
            if (user.Roles != null)
            {
                roleIDs = String.Join(",", user.Roles.Select(r => r.ID).ToArray());
            }

            bool isPersistent = false;
            DateTime expiration = DateTime.Now.AddMinutes(120);
            CreateFormsAuthenticationTicket(user.ID, user.Name, roleIDs, isPersistent, expiration);

            // 重定向到登陆后首页
            Response.Redirect(FormsAuthentication.DefaultUrl);
        }


        #endregion
    }
}
