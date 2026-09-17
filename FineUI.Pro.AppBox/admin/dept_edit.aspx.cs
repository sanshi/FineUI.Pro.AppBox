
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
    public partial class dept_edit : PageBase
    {
        #region ViewPower

        /// <summary>
        /// 本页面的浏览权限，空字符串表示本页面不受权限控制
        /// </summary>
        public override string ViewPower
        {
            get
            {
                return "CoreDeptEdit";
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

        public Dept CurrentDept { get; set; }

        private void LoadData()
        {

            int id = GetQueryIntValue("id");
            Dept current = DB.Depts.Include(d => d.Parent)
                .Where(d => d.ID == id).FirstOrDefault();
            if (current == null)
            {
                // 参数错误，首先弹出Alert对话框然后关闭弹出窗口
                Alert.Show("参数错误！", String.Empty, ActiveWindow.GetHideReference());
                return;
            }

            // 将当前部门保存到属性中，供后续在 Grid1_RowDataBound 中使用
            CurrentDept = current;

            tbxName.Text = current.Name;
            tbxSortIndex.Text = current.SortIndex.ToString();
            tbxRemark.Text = current.Remark;

            // 绑定下拉树表格
            BindParentDDB();
        }


        private void BindParentDDB()
        {
            Grid1.DataSource = DB.Depts.OrderBy(d => d.SortIndex).ToList();
            Grid1.DataBind();

            if (CurrentDept.Parent != null)
            {
                // 当前节点的父节点
                ddbParent.Value = CurrentDept.ParentID.ToString();
                ddbParent.Text = CurrentDept.Parent.Name;
            }
        }

        #endregion


        #region Grid1_RowDataBound

        protected void Grid1_RowDataBound(object sender, GridRowEventArgs e)
        {
            var deptID = Convert.ToInt32(e.RowID);

            // 如果此部门是当前部门（CurrentDept）或者当前部门的子项，则禁止选择
            if (IsOrChildOfCurrentModel(deptID))
            {
                e.RowSelectable = false;
            }
            else
            {
                e.RowSelectable = true;
            }
        }

        private bool IsOrChildOfCurrentModel(int deptID)
        {
            if (deptID == CurrentDept.ID)
            {
                return true;
            }

            var dept = FindModelFromDataSource(deptID);
            if (dept.ParentID != null)
            {
                return IsOrChildOfCurrentModel(dept.ParentID.Value);
            }

            return false;
        }


        // 从表格的数据源中查找指定ID的部门对象
        private Dept FindModelFromDataSource(int deptID)
        {
            Dept result = null;
            var dataSource = Grid1.DataSource as List<Dept>;
            if (dataSource != null && dataSource.Count > 0)
            {
                result = dataSource.FirstOrDefault<Dept>(d => d.ID == deptID);
            }
            return result;
        }

        #endregion

        #region Events

        protected void btnSaveClose_Click(object sender, EventArgs e)
        {
            int id = GetQueryIntValue("id");
            Dept item = DB.Depts.Include(d => d.Parent).Where(d => d.ID == id).FirstOrDefault();
            item.Name = tbxName.Text.Trim();
            item.SortIndex = Convert.ToInt32(tbxSortIndex.Text.Trim());
            item.Remark = tbxRemark.Text.Trim();

            // 设置父部门
            if (!String.IsNullOrEmpty(ddbParent.Value))
            {
                int parentID = Convert.ToInt32(ddbParent.Value);
                item.ParentID = parentID;
            }
            else
            {
                item.ParentID = null;
            }

            DB.SaveChanges();

            //FineUI.Pro.Alert.Show("保存成功！", String.Empty, FineUI.Pro.Alert.DefaultIcon, FineUI.Pro.ActiveWindow.GetHidePostBackReference());
            // 关闭本窗体（触发窗体的关闭事件）
            ActiveWindow.HidePostBack();
        }

        #endregion

    }
}
