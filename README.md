# FineUI.Pro.AppBox

FineUI.Pro.AppBox 是 FineUI 官方应用系统样板，一个基于 FineUI.Pro（社区版）的通用权限管理框架，包含用户、职称、部门、角色与角色权限管理等模块。本仓库是该项目的唯一真相源，欢迎通过 Issue 和 Pull Request 参与技术讨论与改进。

## 依赖方式

项目文件已声明从公共软件包仓库获取的 NuGet 包 `FineUI.Pro`。正常联网构建时，包管理器会自动还原依赖；仓库不包含 FineUI.Core.dll、FineUI.Pro.dll、fineui-java.jar，也不包含 FineUI 框架源码。

## 构建

安装 Visual Studio 的 .NET Framework 4.8 开发工具后，在 Developer PowerShell 中运行：

```powershell
msbuild FineUI.Pro.AppBox.sln /t:Restore /p:RestorePackagesConfig=true
msbuild FineUI.Pro.AppBox.sln /t:Build /p:Configuration=Release
```

## 运行

这是 .NET Framework 4.8 的 ASP.NET WebForms 应用，**没有 `dotnet run` 入口**，只能用 IIS Express 承载：

1. 用 Visual Studio 打开 `FineUI.Pro.AppBox.sln`（安装时需勾选「ASP.NET 和 Web 开发」工作负载）；
2. 直接按 F5 / Ctrl+F5 启动。项目已配置为 IIS Express + 经典管道，端口由 VS 分配、启动后在浏览器地址栏可见，形如 **http://localhost:端口/**。

数据库用 Entity Framework 的 Code First 模式，表结构在第一次运行时自动创建；连接串取自 `Web.config` 的 `connectionStrings:SQLServer`（对应 `FineUI.Pro.AppBoxContext.cs` 里的 `base("SQLServer")`）。默认管理员账号是 `admin`，密码 `admin`。

**不需要授权文件**：本仓库引用的是公共 NuGet 包 `FineUI.Pro`（社区版），社区版不做授权校验，克隆下来就能直接跑。

## 发布历史

各版本的更新内容见 [CHANGELOG.md](CHANGELOG.md)。

## 许可边界

本仓库中由合肥三生石上软件有限公司拥有著作权的示例或应用项目源代码采用 [MIT 许可证](LICENSE)。FineUI 各端框架源码、二进制软件包、内嵌的 FineUI.js 运行时以及 FineUI 名称、标识和商标不属于 MIT 授权范围，仍适用各自的商业或社区版许可。具体边界见 [NOTICE.md](NOTICE.md)。

## 参与贡献

请先阅读 `CONTRIBUTING.md`。安全问题请按 `SECURITY.md` 私下报告。
