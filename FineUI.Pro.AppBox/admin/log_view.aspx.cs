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
    public partial class log_view : PageBase
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

        private void LoadData()
        {

            int id = GetQueryIntValue("id");
            Log log = DB.Logs.Find(id);
            if (log == null)
            {
                // 参数错误，首先弹出Alert对话框然后关闭弹出窗口
                Alert.Show("参数错误！", String.Empty, ActiveWindow.GetHideReference());
                return;
            }

            labDateTime.Text = log.LogTime.ToString("yyyy-MM-dd HH:mm:ss");
            labException.Text = log.Exception;
            labId.Text = log.ID.ToString();
            labLevel.Text = log.Level;
            labMessage.Text = log.Message;
            labSource.Text = log.Logger;
        }

        #endregion

        #region Events

        #endregion

    }
}
