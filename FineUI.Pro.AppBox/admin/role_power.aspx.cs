using FineUI.Pro;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using AspNet = System.Web.UI.WebControls;

namespace FineUI.Pro.AppBox.admin
{
    public partial class role_power : PageBase
    {
        #region ViewPower

        /// <summary>
        /// 本页面的浏览权限，空字符串表示本页面不受权限控制
        /// </summary>
        public override string ViewPower
        {
            get
            {
                return "CoreRolePowerView";
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
            var powerCoreRolePowerEdit = CheckPower("CoreRolePowerEdit");

            // 根据用户权限控制页面控件的可用状态
            btnGroupUpdate.Enabled = powerCoreRolePowerEdit;


            // 每页记录数
            Grid1.PageSize = ConfigHelper.PageSize;
            BindGrid();

            // 默认选中第一个角色
            GridSelectionUtil.SelectFirstRow(Grid1);

            // 每页记录数
            Grid2.PageSize = ConfigHelper.PageSize;
            BindGrid2();
        }

        private void BindGrid()
        {
            IQueryable<Role> q = DB.Roles;

            // 排列
            var roles = q.Sort(Grid1);

            Grid1.DataSource = roles;
            Grid1.DataBind();
        }

        private Dictionary<string, bool> _currentRolePowers = new Dictionary<string, bool>();

        private void BindGrid2()
        {
            // 左侧表格选中的行
            if (String.IsNullOrEmpty(Grid1.SelectedRowID))
            {
                Grid2.DataSource = null;
                Grid2.DataBind();

                return;
            }

            var roleID = Convert.ToInt32(Grid1.SelectedRowID);


            // 当前选中角色拥有的权限列表
            _currentRolePowers.Clear();

            Role role = DB.Roles.Include(r => r.Powers).Where(r => r.ID == roleID).FirstOrDefault();
            foreach (var power in role.Powers)
            {
                string powerName = power.Name;
                if (!_currentRolePowers.ContainsKey(powerName))
                {
                    _currentRolePowers.Add(powerName, true);
                }
            }


            var q = DB.Powers.GroupBy(p => p.GroupName);

            if (Grid2.SortField == "GroupName")
            {
                if (Grid2.SortDirection == "ASC")
                {
                    q = q.OrderBy(g => g.Key);
                }
                else
                {
                    q = q.OrderByDescending(g => g.Key);
                }
            }

            var powers = q.Select(g => new
            {
                GroupName = g.Key,
                Powers = g
            });


            Grid2.DataSource = powers;
            Grid2.DataBind();


        }

        #endregion

        #region Grid1 Events

        protected void Grid1_Sort(object sender, GridSortEventArgs e)
        {
            BindGrid();

            // 默认选中第一个角色
            GridSelectionUtil.SelectFirstRow(Grid1);

            BindGrid2();
        }

        protected void Grid1_RowClick(object sender, FineUI.Pro.GridRowClickEventArgs e)
        {
            BindGrid2();
        }

        #endregion

        #region Grid2 Events

        protected void Grid2_RowDataBound(object sender, FineUI.Pro.GridRowEventArgs e)
        {
            AspNet.CheckBoxList ddlPowers = (AspNet.CheckBoxList)Grid2.Rows[e.RowIndex].FindControl("ddlPowers");

            IGrouping<string, Power> powers = e.DataItem.GetType().GetProperty("Powers").GetValue(e.DataItem, null) as IGrouping<string, Power>;

            foreach (Power power in powers.ToList())
            {
                AspNet.ListItem item = new AspNet.ListItem();
                item.Value = power.ID.ToString();
                // 权限标题是可编辑数据，ListItem.Text 会原样输出到 <label>，这里必须编码
                item.Text = HttpUtility.HtmlEncode(power.Title);
                item.Attributes["data-qtip"] = power.Name;

                if (_currentRolePowers.ContainsKey(power.Name))
                {
                    item.Selected = true;
                }
                else
                {
                    item.Selected = false;
                }

                ddlPowers.Items.Add(item);
            }
        }



        protected void Grid2_Sort(object sender, GridSortEventArgs e)
        {
            BindGrid2();
        }

        protected void btnGroupUpdate_Click(object sender, EventArgs e)
        {
            // 在操作之前进行权限检查
            if (!CheckPower("CoreRolePowerEdit"))
            {
                CheckPowerFailWithAlert();
                return;
            }

            if (String.IsNullOrEmpty(Grid1.SelectedRowID))
            {
                return;
            }
            var roleID = Convert.ToInt32(Grid1.SelectedRowID);


            // 当前角色新的权限列表
            List<int> newPowerIDs = new List<int>();
            for (int i = 0; i < Grid2.Rows.Count; i++)
            {
                AspNet.CheckBoxList ddlPowers = (AspNet.CheckBoxList)Grid2.Rows[i].FindControl("ddlPowers");
                foreach (AspNet.ListItem item in ddlPowers.Items)
                {
                    if (item.Selected)
                    {
                        newPowerIDs.Add(Convert.ToInt32(item.Value));
                    }
                }
            }


            Role role = DB.Roles.Include(r => r.Powers).Where(r => r.ID == roleID).FirstOrDefault();

            ReplaceEntities<Power>(role.Powers, newPowerIDs.ToArray());

            DB.SaveChanges();


            Alert.ShowInTop("当前角色的权限更新成功！");
        }


        #endregion

    }
}
