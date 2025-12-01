# TianClash Git 迁移命令

# 步骤 1: 创建新分支
Write-Host "正在创建 tianclash-refactor 分支..." -ForegroundColor Green
git checkout -b tianclash-refactor

# 步骤 2: 添加 TianClash 远程仓库
Write-Host "正在添加远程仓库..." -ForegroundColor Green
git remote add tianclash https://github.com/wxfyes/TianClash.git

# 步骤 3: 查看当前状态
Write-Host "当前状态：" -ForegroundColor Yellow
git status

# 步骤 4: 添加所有修改
Write-Host "正在添加文件..." -ForegroundColor Green
git add .

# 步骤 5: 提交改动
Write-Host "正在提交改动..." -ForegroundColor Green
git commit -m "feat: 初始化TianClash项目

- 重构导航栏：隐藏节点入口，商店改为套餐
- 添加仪表盘重构计划文档
- 完成第一阶段准备工作
- 基于FlClash v0.8.88"

# 步骤 6: 推送到新仓库
Write-Host "正在推送到 TianClash 仓库..." -ForegroundColor Green
git push -u tianclash tianclash-refactor:main

Write-Host "✅ 迁移完成！" -ForegroundColor Green
Write-Host "您的项目已推送到: https://github.com/wxfyes/TianClash" -ForegroundColor Cyan
