using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using FineUI.Pro;

namespace FineUI.Pro.AppBox.Public
{
    /// <summary>
    /// 通知公告：无需登录即可访问的公开页示例。
    ///
    /// 能匿名访问，靠的是 Web.config 里为 public 目录单独放开了匿名访问
    /// （站点根的 authorization 节是 deny users="?"，即默认全站要求登录，再用 location 节按目录开门）。
    /// 页面自身不需要任何声明——新增一个公开页只要放进 public 目录，Web.config 不用再改。
    ///
    /// 两件事因此成立：
    ///   1. 本类不重写 ViewPower——那个属性管的是「登录用户有没有这一页的权限」，与「要不要登录」无关，
    ///      基类默认返回空字符串就是不受权限控制；
    ///   2. 本类照常继承 PageBase，基类里取当前用户的方法在未登录时都返回 null、不会出错。
    ///
    /// 页面里的搜索与翻页都是回发，能正常工作说明匿名会话下的回发通道是通的。
    /// </summary>
    public partial class notice : PageBase
    {
        #region Page_Load

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // 匿名访问时没有身份，取任何用户信息之前都要先判断是否已登录
                labSignedIn.Text = User.Identity.IsAuthenticated
                    ? String.Format("您已登录为 {0}", GetIdentityName())
                    : "您当前未登录，可直接浏览公告";

                LoadData();
            }
        }

        private void LoadData()
        {
            string searchText = ttbSearchTitle.Text != null ? ttbSearchTitle.Text.Trim() : null;
            var filtered = NoticeData.GetAll();
            if (!String.IsNullOrEmpty(searchText))
            {
                filtered = filtered
                    .Where(x => x.Title.IndexOf(searchText, StringComparison.OrdinalIgnoreCase) >= 0)
                    .ToList();
            }

            // 数据在内存里，分页自己算（查数据库的页面走 SQL 分页，这里手工 Skip/Take）
            Grid1.RecordCount = filtered.Count;
            Grid1.DataSource = filtered.Skip(Grid1.PageIndex * Grid1.PageSize).Take(Grid1.PageSize).ToList();
            Grid1.DataBind();
        }

        #endregion


        #region Events

        protected void Grid1_PageIndexChange(object sender, GridPageEventArgs e)
        {
            LoadData();
        }

        protected void ttbSearchTitle_Trigger1Click(object sender, EventArgs e)
        {
            ttbSearchTitle.Text = String.Empty;
            ttbSearchTitle.ShowTrigger1 = false;
            Grid1.PageIndex = 0;
            LoadData();
        }

        protected void ttbSearchTitle_Trigger2Click(object sender, EventArgs e)
        {
            ttbSearchTitle.ShowTrigger1 = true;
            Grid1.PageIndex = 0;
            LoadData();
        }

        #endregion
    }
}
