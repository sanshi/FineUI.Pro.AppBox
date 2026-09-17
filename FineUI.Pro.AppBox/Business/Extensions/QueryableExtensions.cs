using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using FineUI.Pro;

namespace FineUI.Pro.AppBox
{
    public static class QueryableExtensions
    {
        #region Extensions

        /// <summary>
        /// 对 IQueryable 进行排序和分页，并返回结果列表
        /// </summary>
        /// <typeparam name="T">实体类型</typeparam>
        /// <param name="q">数据源</param>
        /// <param name="grid">Grid 控件，包含分页和排序信息</param>
        /// <returns>排序和分页后的结果列表</returns>
        public static List<T> SortAndPage<T>(this IQueryable<T> q, Grid grid) where T : class
        {
            //return await SortAndPageAsync(q, grid.PageIndex, grid.PageSize, grid.RecordCount, grid.SortField, grid.SortDirection);

            if (grid.PageIndex >= grid.PageCount && grid.PageCount >= 1)
            {
                grid.PageIndex = grid.PageCount - 1;
            }

            return q.SortBy(grid.SortField + " " + grid.SortDirection).Skip(grid.PageIndex * grid.PageSize).Take(grid.PageSize).ToList();
        }


        /// <summary>
        /// 对 IQueryable 进行排序，并返回结果列表
        /// </summary>
        /// <typeparam name="T">实体类型</typeparam>
        /// <param name="q">数据源</param>
        /// <param name="grid">Grid 控件，包含分页和排序信息</param>
        /// <returns>排序后的结果列表</returns>
        public static List<T> Sort<T>(this IQueryable<T> q, Grid grid) where T : class
        {
            return q.SortBy(grid.SortField + " " + grid.SortDirection).ToList();
        }




        //// 排序
        //protected IQueryable<T> Sort<T>(IQueryable<T> q, FineUI.Pro.Grid grid)
        //{
        //    return q.SortBy(grid.SortField + " " + grid.SortDirection);
        //}

        //// 排序后分页
        //protected IQueryable<T> SortAndPage<T>(IQueryable<T> q, FineUI.Pro.Grid grid)
        //{
        //    if (grid.PageIndex >= grid.PageCount && grid.PageCount >= 1)
        //    {
        //        grid.PageIndex = grid.PageCount - 1;
        //    }

        //    return Sort(q, grid).Skip(grid.PageIndex * grid.PageSize).Take(grid.PageSize);
        //}


        #endregion


        
    }
}