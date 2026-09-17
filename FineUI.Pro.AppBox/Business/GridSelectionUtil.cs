using FineUI.Pro;

namespace FineUI.Pro.AppBox
{
    /// <summary>
    /// 表格选择的公共操作。
    /// </summary>
    public static class GridSelectionUtil
    {
        /// <summary>
        /// 按稳定行ID选中当前数据中的第一行；没有数据时清空选择。
        /// </summary>
        public static void SelectFirstRow(Grid grid)
        {
            if (grid.Rows.Count > 0)
            {
                grid.SelectedRowID = grid.Rows[0].RowID;
            }
            else
            {
                grid.SelectedRowIDArray = null;
            }
        }
    }
}
