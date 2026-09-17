using EntityFramework.Extensions;
using FineUI.Pro;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FineUI.Pro.AppBox.admin
{
    public partial class user : PageBase
    {
        #region ViewPower

        /// <summary>
        /// 本页面的浏览权限，空字符串表示本页面不受权限控制
        /// </summary>
        public override string ViewPower
        {
            get
            {
                return "CoreUserView";
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

        protected void Page_CustomEvent(object sender, CustomEventArgs e)
        {
            if (e.EventName == "Grid1_DeleteRows")
            {
                int[] rowIDs = e.EventArgumentsAsJObject.Value<JArray>("rowIDs").ToObject<int[]>();
                DeleteRows(rowIDs);
            }
            else if (e.EventName == "Grid1_EnableRows")
            {
                JObject eventArguments = e.EventArgumentsAsJObject;
                int[] rowIDs = eventArguments.Value<JArray>("rowIDs").ToObject<int[]>();
                SetSelectedUsersEnableStatus(eventArguments.Value<string>("action") == "enable", rowIDs);
            }
        }

        private void LoadData()
        {
            var powerCoreUserNew = CheckPower("CoreUserNew");
            var powerCoreUserEdit = CheckPower("CoreUserEdit");
            var powerCoreUserDelete = CheckPower("CoreUserDelete");
            var powerCoreUserChangePassword = CheckPower("CoreUserChangePassword");

            // 根据用户权限控制页面控件的可用状态
            btnNew.Enabled = powerCoreUserNew;
            btnChangeEnableUsers.Enabled = powerCoreUserEdit;
            btnDeleteSelected.Enabled = powerCoreUserDelete;


            // 行内编辑按钮的权限
            Grid1.FindColumn("editField").Enabled = powerCoreUserEdit;
            // 行内删除按钮的权限
            Grid1.FindColumn("deleteField").Enabled = powerCoreUserDelete;
            // 行内删除按钮的权限
            Grid1.FindColumn("changePasswordField").Enabled = powerCoreUserChangePassword;

            // 每页记录数
            Grid1.PageSize = ConfigHelper.PageSize;
            ddlGridPageSize.SelectedValue = ConfigHelper.PageSize.ToString();

            BindGrid();
        }

        private void BindGrid()
        {
            IQueryable<User> q = DB.Users; //.Include(u => u.CurrentDept);

            // 在用户名称中搜索
            string searchText = ttbSearchMessage.Text?.Trim();
            if (!String.IsNullOrEmpty(searchText))
            {
                q = q.Where(u => u.Name.Contains(searchText) || u.ChineseName.Contains(searchText) || u.EnglishName.Contains(searchText));
            }

            if (GetIdentityName() != "admin")
            {
                q = q.Where(u => u.Name != "admin");
            }

            // 过滤启用状态
            if (rblEnableStatus.SelectedValue != "all")
            {
                q = q.Where(u => u.Enabled == (rblEnableStatus.SelectedValue == "enabled" ? true : false));
            }

            // 在查询添加之后，排序和分页之前获取总记录数
            Grid1.RecordCount = q.Count();

            // 排列和数据库分页
            var users = q.SortAndPage(Grid1);


            Grid1.DataSource = users;
            Grid1.DataBind();
        }

        #endregion

        #region Events

        protected void ttbSearchMessage_Trigger2Click(object sender, EventArgs e)
        {
            ttbSearchMessage.ShowTrigger1 = true;
            BindGrid();
        }

        protected void ttbSearchMessage_Trigger1Click(object sender, EventArgs e)
        {
            ttbSearchMessage.Text = String.Empty;
            ttbSearchMessage.ShowTrigger1 = false;
            BindGrid();
        }

        protected void Grid1_Sort(object sender, GridSortEventArgs e)
        {
            BindGrid();
        }

        protected void Grid1_PageIndexChange(object sender, GridPageEventArgs e)
        {
            BindGrid();
        }


        // 选中行的标识由客户端随自定义回发送上来
        private void SetSelectedUsersEnableStatus(bool enabled, int[] rowIDs)
        {
            // 在操作之前进行权限检查
            if (!CheckPower("CoreUserEdit"))
            {
                CheckPowerFailWithAlert();
                return;
            }

            // 执行数据库操作
            // 列表里看不到 admin，但回传的主键不可信：超级管理员不能被禁用
            if (DB.Users.Any(u => rowIDs.Contains(u.ID) && u.Name == "admin"))
            {
                Alert.ShowInTop("不能修改超级管理员（admin）的启用状态！");
                return;
            }

            DB.Users.Where(u => rowIDs.Contains(u.ID)).Update(u => new User { Enabled = enabled });

            // 重新绑定表格
            BindGrid();
        }

        protected void Grid1_RowCommand(object sender, GridCommandEventArgs e)
        {
            int userID = Convert.ToInt32(Grid1.SelectedRowID);
            
            if (e.CommandName == "Delete")
            {
                DeleteRows(new int[] { userID });
            }
        }

        protected void Window1_Close(object sender, EventArgs e)
        {
            BindGrid();
        }

        protected void rblEnableStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindGrid();
        }


        protected void ddlGridPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            Grid1.PageSize = Convert.ToInt32(ddlGridPageSize.SelectedValue);

            BindGrid();
        }

        #endregion

        #region DeleteRows

        private void DeleteRows(int[] rowIDs)
        {
            if (!CheckPower("CoreUserDelete"))
            {
                CheckPowerFailWithAlert();
                return;
            }

            //bool hasAdmin = DB.Users.Any(u => rowIDs.Contains(u.ID) && u.Name == "admin");

            var usersToDelete = DB.Users.Where(u => rowIDs.Contains(u.ID)).ToList();

            if (usersToDelete.Any(u => u.Name == "admin"))
            {
                Alert.ShowInTop("不能删除超级管理员（admin）！");
                return;
            }

            // 使用EntityFramework.Extended进行批量删除
            DB.Users.Where(u => rowIDs.Contains(u.ID)).Delete();

            BindGrid();
        }

        #endregion
    }
}
