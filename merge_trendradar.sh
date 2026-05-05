#!/bin/bash

# 定义变量
UPSTREAM_NAME="upstream_trendradar"
UPSTREAM_URL="https://github.com/sansan0/TrendRadar.git"
TARGET_BRANCH=$(git rev-parse --abbrev-ref HEAD)

echo "🚀 开始同步 TrendRadar 最新代码..."
echo "当前分支: $TARGET_BRANCH"

# 1. 检查是否已经添加了 upstream 远程仓库
if ! git remote | grep -q "^$UPSTREAM_NAME$"; then
    echo "ℹ️  未检测到上游远程仓库，正在添加: $UPSTREAM_NAME"
    git remote add $UPSTREAM_NAME $UPSTREAM_URL
else
    echo "✅ 上游远程仓库已存在。"
fi

# 2. 获取上游仓库的最新数据
echo "⬇️  正在获取最新提交..."
git fetch $UPSTREAM_NAME

# 3. 合并最新提交
# 这里使用 merge 策略。如果你想保持提交历史整洁，也可以改为 'git rebase'
echo "🔗 正在合并 $UPSTREAM_NAME/master 到当前分支..."
git merge $UPSTREAM_NAME/master

# 4. 检查结果
if [ $? -eq 0 ]; then
    echo "🎉 合并成功！"
    echo "💡 提示：如果本地有未推送的更改，请记得执行 'git push'。"
else
    echo "❌ 合并过程中发生冲突，请手动解决冲突后提交。"
fi