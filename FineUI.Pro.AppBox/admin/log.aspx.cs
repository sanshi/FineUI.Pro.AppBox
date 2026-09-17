using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;
using System.Data.Entity;
using FineUI.Pro;
using Newtonsoft.Json.Linq;
using EntityFramework.Extensions;

namespace FineUI.Pro.AppBox.admin
{
    public partial class log : PageBase
    {
        #region ViewPower

        /// <summary>
        /// 本页面的浏览权限，空字符串表示本页面不受权限控制
        /// </summary>
        public override string ViewPower
        {
            get
            {
                return "CoreLogView";
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
        }

        private void LoadData()
        {
            var powerCoreLogDelete = CheckPower("CoreLogDelete");

            // 根据用户权限控制页面控件的可用状态
            btnDeleteSelected.Enabled = powerCoreLogDelete;

            // 行内删除按钮的权限
            Grid1.FindColumn("deleteField").Enabled = powerCoreLogDelete;


            // 每页记录数
            Grid1.PageSize = ConfigHelper.PageSize;
            ddlGridPageSize.SelectedValue = ConfigHelper.PageSize.ToString();

            BindGrid();
        }

        private void BindGrid()
        {
            IQueryable<Log> q = DB.Logs;

            // 在错误信息中搜索
            string searchText = ttbSearchMessage.Text?.Trim();
            if (!String.IsNullOrEmpty(searchText))
            {
                q = q.Where(l => l.Message.Contains(searchText));
            }

            // 过滤错误级别
            if (ddlSearchLevel.SelectedValue != "ALL")
            {
                q = q.Where(l => l.Level == ddlSearchLevel.SelectedValue);
            }

            // 过滤搜索范围
            if (ddlSearchRange.SelectedValue != "ALL")
            {
                DateTime today = DateTime.Parse(DateTime.Now.ToString("yyyy-MM-dd"));
                switch (ddlSearchRange.SelectedValue)
                {
                    case "TODAY":
                        q = q.Where(l => l.LogTime >= today);
                        break;
                    case "LAST3DAYS":
                        q = q.Where(l => l.LogTime >= today.AddDays(-3));
                        break;
                    case "LAST7DAYS":
                        q = q.Where(l => l.LogTime >= today.AddDays(-7));
                        break;
                    case "LASTMONTH":
                        q = q.Where(l => l.LogTime >= today.AddMonths(-1));
                        break;
                    case "LASTYEAR":
                        q = q.Where(l => l.LogTime >= today.AddYears(-1));
                        break;
                }
            }


            // 在查询添加之后，排序和分页之前获取总记录数
            Grid1.RecordCount = q.Count();


            // 排列和分页
            var logs = q.SortAndPage(Grid1);

            Grid1.DataSource = logs;
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

        protected void ddlSearchLevel_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindGrid();
        }

        protected void ddlSearchRange_SelectedIndexChanged(object sender, EventArgs e)
        {
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

        // 选中行的标识由客户端通过 F.customEvent 的结构化参数传入。
        private void DeleteRows(int[] rowIDs)
        {
            // 在操作之前进行权限检查
            if (!CheckPower("CoreLogDelete"))
            {
                CheckPowerFailWithAlert();
                return;
            }

            // 执行数据库操作
            DB.Logs.Where(l => rowIDs.Contains(l.ID)).Delete();

            // 重新绑定表格
            BindGrid();
        }

        protected void Grid1_RowCommand(object sender, GridCommandEventArgs e)
        {
            int logID = Convert.ToInt32(Grid1.SelectedRowID);

            if (e.CommandName == "Delete")
            {
                // 在操作之前进行权限检查
                if (!CheckPower("CoreLogDelete"))
                {
                    CheckPowerFailWithAlert();
                    return;
                }

                DB.Logs.Where(l => l.ID == logID).Delete();
                

                BindGrid();
            }
        }

        protected void ddlGridPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            Grid1.PageSize = Convert.ToInt32(ddlGridPageSize.SelectedValue);

            BindGrid();
        }

        #endregion

    }
}
