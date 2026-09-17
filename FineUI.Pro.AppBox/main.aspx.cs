
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

using Newtonsoft.Json.Linq;
using FineUI.Pro;
using System.Linq;
using System.Data.Entity;


namespace FineUI.Pro.AppBox
{
    public partial class main : PageBase
    {
        #region Page_Init

        protected void Page_Init(object sender, EventArgs e)
        {
            // 工具栏上的帮助菜单
            JArray ja = JArray.Parse(ConfigHelper.HelpList);
            foreach (JObject jo in ja)
            {
                MenuButton menuItem = new MenuButton();
                string id = jo.Value<string>("ID");
                string url = jo.Value<string>("URL");
                string text = jo.Value<string>("Text");
                menuItem.Text = text;
                menuItem.Icon = IconHelper.String2Icon(jo.Value<string>("Icon"), true);
                menuItem.Attributes["data-id"] = id;
                menuItem.Attributes["data-url"] = ResolveUrl(url);
                menuItem.Attributes["data-text"] = text;
                menuItem.ClickHandler = "onHelpMenuClick";

                btnHelp.Menu.Items.Add(menuItem);
            }

            // 用户可见的菜单列表
            List<Menu> menus = ResolveUserMenuList();
            if (menus.Count == 0)
            {
                Response.Write("系统管理员尚未给你配置菜单！");
                Response.End();

                return;
            }

            InitTreeMenu(menus);

        }

        #region InitTreeMenu

        /// <summary>
        /// 创建树菜单
        /// </summary>
        /// <param name="menus"></param>
        /// <returns></returns>
        private Tree InitTreeMenu(List<Menu> menus)
        {
            // 生成树
            ResolveMenuTree(menus, null, treeMenu.Nodes);

            // 展开第一个树节点
            treeMenu.Nodes[0].Expanded = true;

            return treeMenu;
        }

        /// <summary>
        /// 生成菜单树
        /// </summary>
        /// <param name="menus"></param>
        /// <param name="parentMenuID"></param>
        /// <param name="nodes"></param>
		/// <returns>当前目录下有多少个子节点</returns>
        private int ResolveMenuTree(List<Menu> menus, int? parentMenuID, FineUI.Pro.TreeNodeCollection nodes)
        {
            int count = 0;
            foreach (var menu in menus.Where(m => m.ParentID == parentMenuID))
            {
                FineUI.Pro.TreeNode node = new FineUI.Pro.TreeNode();
                nodes.Add(node);
                count++;

                node.Text = menu.Name;
                node.IconUrl = menu.ImageUrl;
                if (!String.IsNullOrEmpty(menu.NavigateUrl))
                {
                    node.NavigateUrl = ResolveUrl(menu.NavigateUrl);
                }

                int childCount = ResolveMenuTree(menus, menu.ID, node.Nodes);

                // 如果当前节点是子节点
                if (childCount == 0)
                {
                    node.Leaf = true;

                    // 但是此节点不是超链接，则删除
                    if (String.IsNullOrEmpty(menu.NavigateUrl))
                    {
                        nodes.Remove(node);
                        count--;
                    }
                }

            }

            return count;
        }

        #endregion

        #region ResolveUserMenuList

        // 获取用户可用的菜单列表
        private List<Menu> ResolveUserMenuList()
        {
            // 当前登陆用户的权限列表
            List<string> rolePowerNames = GetRolePowerNames();

            // 当前用户所属角色可用的菜单列表
            List<Menu> menus = new List<Menu>();

            List<Menu> allMenus = DB.Menus.Include(m => m.ViewPower).OrderBy(m => m.SortIndex).ToList();

            foreach (var menu in allMenus)
            {
                // 如果此菜单不属于任何模块，或者此用户所属角色拥有对此模块的权限
                if (menu.ViewPowerID == null || rolePowerNames.Contains(menu.ViewPowerName))
                {
                    menus.Add(menu);
                }
            }

            return menus;
        } 

        #endregion

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
            btnUserName.Text = GetIdentityName();

        }


        #endregion

        #region Events

        protected void btnExit_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Abandon();

            FormsAuthentication.RedirectToLoginPage();
        }

        #endregion
    }
}
