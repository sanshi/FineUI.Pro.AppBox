using System;
using System.Data.Entity;
using System.Linq;
using FineUI.Pro;

namespace FineUI.Pro.AppBox.admin
{
    public partial class user_edit : PageBase
    {
        #region ViewPower

        /// <summary>
        /// 本页面的浏览权限，空字符串表示本页面不受权限控制
        /// </summary>
        public override string ViewPower
        {
            get
            {
                return "CoreUserEdit";
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

        public User CurrentUser { get; set; }

        private void LoadData()
        {

            int id = GetQueryIntValue("id");
            User current = DB.Users
                .Include(u => u.Dept)
                .Include(u => u.Roles)
                .Include(u => u.Titles)
                .Where(u => u.ID == id).FirstOrDefault();
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

            // 将当前用户保存到属性中，供后续代码使用
            CurrentUser = current;


            labName.Text = current.Name;
            tbxRealName.Text = current.ChineseName;
            tbxCompanyEmail.Text = current.CompanyEmail;
            tbxEmail.Text = current.Email;
            tbxCellPhone.Text = current.CellPhone;
            tbxOfficePhone.Text = current.OfficePhone;
            tbxOfficePhoneExt.Text = current.OfficePhoneExt;
            tbxHomePhone.Text = current.HomePhone;
            tbxRemark.Text = current.Remark;
            cbxEnabled.Checked = current.Enabled;
            ddlGender.SelectedValue = current.Gender;

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
            // 用户所属部门
            if (CurrentUser.Dept != null)
            {
                ddbDept.Value = CurrentUser.DeptID.ToString();
                ddbDept.Text = CurrentUser.DeptName;
            }

            gridDept.DataSource = DB.Depts.OrderBy(d => d.SortIndex).ToList();
            gridDept.DataBind();

        }

        #endregion

        #region InitUserRole

        private void InitUserRole()
        {
            // 用户所属角色
            if (CurrentUser.Roles.Count > 0)
            {
                ddbRoles.Values = CurrentUser.Roles.Select(r => r.ID.ToString()).ToArray();
                ddbRoles.Texts = CurrentUser.Roles.Select(r => r.Name).ToArray();
            }

            cblRoles.DataSource = DB.Roles.ToList();
            cblRoles.DataBind();

        }
        #endregion

        #region InitUserTitle

        private void InitUserTitle()
        {
            // 用户拥有职称
            if (CurrentUser.Titles.Count > 0)
            {
                ddbTitles.Values = CurrentUser.Titles.Select(u => u.ID.ToString()).ToArray();
                ddbTitles.Texts = CurrentUser.Titles.Select(u => u.Name).ToArray();
            }

            cblTitles.DataSource = DB.Titles.ToList();
            cblTitles.DataBind();
        }
        #endregion


        #endregion

        #region Events

        protected void btnSaveClose_Click(object sender, EventArgs e)
        {
            int id = GetQueryIntValue("id");
            User item = DB.Users
                .Include(u => u.Dept)
                .Include(u => u.Roles)
                .Include(u => u.Titles)
                .Where(u => u.ID == id).FirstOrDefault();
            

            item.ChineseName = tbxRealName.Text.Trim();
            item.Gender = ddlGender.SelectedValue;
            item.CompanyEmail = tbxCompanyEmail.Text.Trim();
            item.Email = tbxEmail.Text.Trim();
            item.CellPhone = tbxCellPhone.Text.Trim();
            item.OfficePhone = tbxOfficePhone.Text.Trim();
            item.OfficePhoneExt = tbxOfficePhoneExt.Text.Trim();
            item.HomePhone = tbxHomePhone.Text.Trim();
            item.Remark = tbxRemark.Text.Trim();
            item.Enabled = cbxEnabled.Checked;



			// 更新用户所属的角色
            int[] roleIDs = ddbRoles.Values.Select(r => Convert.ToInt32(r)).ToArray();
            ReplaceEntities<Role>(item.Roles, roleIDs);

            // 更新用户拥有的职称
            int[] titleIDs = ddbTitles.Values.Select(r => Convert.ToInt32(r)).ToArray();
            ReplaceEntities<Title>(item.Titles, titleIDs);

            // 如果选择了部门，则更新部门ID，否则设置为null
            if (!String.IsNullOrEmpty(ddbDept.Value))
            {
                var newDeptID = Convert.ToInt32(ddbDept.Value);
                item.DeptID = newDeptID;
            }
            else
            {
                item.DeptID = null;
            }
			

            DB.SaveChanges();


            // 关闭本窗体（触发窗体的关闭事件）
            ActiveWindow.HidePostBack();
        }

        #endregion

    }
}
