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
    public partial class dept_new : PageBase
    {
        #region ViewPower

        /// <summary>
        /// 本页面的浏览权限，空字符串表示本页面不受权限控制
        /// </summary>
        public override string ViewPower
        {
            get
            {
                return "CoreDeptNew";
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

            // 绑定下拉树表格
            BindParentDDB();
        }
		
		private void BindParentDDB()
        {
            Grid1.DataSource = DB.Depts.OrderBy(d => d.SortIndex).ToList();
            Grid1.DataBind();
        }


        #endregion

        #region Events

        private void SaveItem()
        {
            Dept item = new Dept();
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
			
			

            DB.Depts.Add(item);
            DB.SaveChanges();
        }

        protected void btnSaveClose_Click(object sender, EventArgs e)
        {
            SaveItem();

            //Alert.Show("添加成功！", String.Empty, ActiveWindow.GetHidePostBackReference());
            // 关闭本窗体（触发窗体的关闭事件）
            ActiveWindow.HidePostBack();
        }

        #endregion

    }
}
