using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

namespace FineUI.Pro.AppBox
{
    public class AppBoxContext : DbContext
    {
        public AppBoxContext() : base("SQLServer")
        {
        }

        public DbSet<Config> Configs { get; set; }
        public DbSet<Dept> Depts { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Role> Roles { get; set; }
        public DbSet<Title> Titles { get; set; }
        public DbSet<Online> Onlines { get; set; }
        public DbSet<Log> Logs { get; set; }
        public DbSet<Power> Powers { get; set; }
        public DbSet<Menu> Menus { get; set; }


        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);


            modelBuilder.Entity<Role>()
                .HasMany(r => r.Users)
                .WithMany(u => u.Roles)
                .Map(x => x.ToTable("RoleUsers")
                    .MapLeftKey("RoleID")
                    .MapRightKey("UserID"));

            modelBuilder.Entity<Title>()
                .HasMany(t => t.Users)
                .WithMany(u => u.Titles)
                .Map(x => x.ToTable("TitleUsers")
                    .MapLeftKey("TitleID")
                    .MapRightKey("UserID"));

            modelBuilder.Entity<Role>()
                .HasMany(r => r.Powers)
                .WithMany(p => p.Roles)
                .Map(x => x.ToTable("RolePowers")
                    .MapLeftKey("RoleID")
                    .MapRightKey("PowerID"));

            // 自包含
            modelBuilder.Entity<Dept>()
                .HasOptional(d => d.Parent)
                .WithMany(d => d.Children)
                .HasForeignKey(d => d.ParentID);

            modelBuilder.Entity<Menu>()
                .HasOptional(m => m.Parent)
                .WithMany(m => m.Children)
                .HasForeignKey(m => m.ParentID);


            // 一对多
            modelBuilder.Entity<User>()
                .HasOptional(u => u.Dept)
                .WithMany(d => d.Users)
                .HasForeignKey(u => u.DeptID);

            // 单个导航属性
            modelBuilder.Entity<Online>()
                .HasRequired(o => o.User)
                .WithMany()
                .HasForeignKey(d => d.UserID);

            modelBuilder.Entity<Menu>()
                .HasOptional(m => m.ViewPower)
                .WithMany()
                .HasForeignKey(m => m.ViewPowerID);


        }
    }
}