using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;

using FineUI.Pro;

namespace FineUI.Pro.AppBox.Public
{
    /// <summary>
    /// 公告详情（弹窗内打开）：同样无需登录，因为它也在放开了匿名访问的 public 目录下。
    ///
    /// 它既能被列表页的弹窗打开，也能把地址直接发给别人打开（例如 ~/public/notice_detail.aspx?id=8）——
    /// 这正是「公告链接可以往外发」想要的效果。
    ///
    /// 参数取值仍要当作不可信输入：查不到记录就提示并关闭弹窗、不渲染内容。
    /// </summary>
    public partial class notice_detail : PageBase
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

            int id = GetQueryIntValue("id");
            Notice current = NoticeData.Find(id);
            if (current == null)
            {
                // 参数错误，首先弹出Alert对话框然后关闭弹出窗口
                Alert.Show("公告不存在或已撤回！", String.Empty, ActiveWindow.GetHideReference());
                return;
            }

            labTitle.Text = current.Title;
            labDepartment.Text = current.Department;
            labPublishTime.Text = current.PublishTime.ToString("yyyy-MM-dd HH:mm");
            labContent.Text = current.Content;
        }

        #endregion
    }
}
