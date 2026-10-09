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

            // 分组查询先执行，再生成供浏览器渲染的数组，避免数据库翻译本地方法调用。
            var powers = q.ToList().Select(g => new
            {
                GroupName = g.Key,
                Powers = GetPowerData(g)
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

        // 同时绑定权限内容和当前角色的勾选状态，排序或切换角色后仍显示数据库中的授权结果。
        private JArray GetPowerData(IEnumerable<Power> powers)
        {
            JArray result = new JArray();
            foreach (Power power in powers)
            {
                result.Add(new JObject
                {
                    { "id", power.ID },
                    { "name", power.Name },
                    { "title", power.Title },
                    { "selected", _currentRolePowers.ContainsKey(power.Name) }
                });
            }
            return result;
        }

        protected void Grid2_Sort(object sender, GridSortEventArgs e)
        {
            BindGrid2();
        }

        protected void Page_CustomEvent(object sender, CustomEventArgs e)
        {
            if (e.EventName != "Grid2_SavePowers")
            {
                return;
            }

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


            // 浏览器提交勾选的权限编号，服务端仍先检查修改权限，再保存授权。
            List<int> newPowerIDs = e.EventArgumentsAsJObject.Value<JArray>("powerIDs").ToObject<List<int>>();

            Role role = DB.Roles.Include(r => r.Powers).Where(r => r.ID == roleID).FirstOrDefault();

            ReplaceEntities<Power>(role.Powers, newPowerIDs.ToArray());

            DB.SaveChanges();


            Alert.ShowInTop("当前角色的权限更新成功！");
        }


        #endregion

    }
}
