
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
    public partial class user_new : PageBase
    {
        #region ViewPower

        /// <summary>
        /// 本页面的浏览权限，空字符串表示本页面不受权限控制
        /// </summary>
        public override string ViewPower
        {
            get
            {
                return "CoreUserNew";
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

            // 初始化用户所属角色
            InitUserRole();

            // 初始化用户所属部门
            InitUserDept();

            // 初始化用户所属职称
            InitUserTitle();
        }

        #region InitUserDept

        private void InitUserDept()
        {
            gridDept.DataSource = DB.Depts.OrderBy(d => d.SortIndex).ToList();
            gridDept.DataBind();

        }

        #endregion

        #region InitUserRole

        private void InitUserRole()
        {
            cblRoles.DataSource = DB.Roles.ToList();
            cblRoles.DataBind();

        }
        #endregion

        #region InitUserTitle

        private void InitUserTitle()
        {
            cblTitles.DataSource = DB.Titles.ToList();
            cblTitles.DataBind();
        }

        #endregion

        #endregion

        #region Events


        protected void btnSaveClose_Click(object sender, EventArgs e)
        {
            string inputUserName = tbxName.Text.Trim();

            User user = DB.Users.Where(u => u.Name == inputUserName).FirstOrDefault();

            if (user != null)
            {
                Alert.Show("用户 " + inputUserName + " 已经存在！");
                return;
            }

            User item = new User();
            item.Name = tbxName.Text.Trim();
            item.Password = PasswordUtil.CreateDbPassword(tbxPassword.Text.Trim());
            item.ChineseName = tbxRealName.Text.Trim();
            item.Gender = ddlGender.SelectedValue;
            item.CompanyEmail = tbxCompanyEmail.Text.Trim();
            item.Email = tbxEmail.Text.Trim();
            item.OfficePhone = tbxOfficePhone.Text.Trim();
            item.OfficePhoneExt = tbxOfficePhoneExt.Text.Trim();
            item.HomePhone = tbxHomePhone.Text.Trim();
            item.CellPhone = tbxCellPhone.Text.Trim();
            item.Remark = tbxRemark.Text.Trim();
            item.Enabled = cbxEnabled.Checked;
            item.CreateTime = DateTime.Now;


            // 添加角色
            if (ddbRoles.Values != null && ddbRoles.Values.Length > 0)
            {
                item.Roles = new List<Role>();

                int[] roleIDs = ddbRoles.Values.Select(r => Convert.ToInt32(r)).ToArray();
                AddEntities<Role>(item.Roles, roleIDs);
            }

            // 添加职称
            if (ddbTitles.Values != null && ddbTitles.Values.Length > 0)
            {
                item.Titles = new List<Title>();

                int[] titleIDs = ddbTitles.Values.Select(r => Convert.ToInt32(r)).ToArray();
                ReplaceEntities<Title>(item.Titles, titleIDs);
            }

            // 添加所有部门
            if (ddbDept.Value != null)
            {
                var newDeptID = Convert.ToInt32(ddbDept.Value);
                item.DeptID = newDeptID;
            }

            DB.Users.Add(item);
            DB.SaveChanges();


            // 关闭本窗体（触发窗体的关闭事件）
            ActiveWindow.HidePostBack();
        }
        #endregion

    }
}
