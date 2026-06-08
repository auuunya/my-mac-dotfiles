# 本地覆写

仓库里只保留通用配置。

如果你需要加入自己的身份信息、别名或额外环境变量，建议放到本地覆写文件中，不要直接改模板文件。

## 建议方式

- Git 身份信息：`~/.gitconfig.local`
- Shell 私有配置：`~/.zshrc.local`
- 额外运行时配置：`.mise.local.toml`

## 使用步骤

1. 复制示例文件
2. 改成自己的内容
3. 保持这些文件不提交

## 示例

```bash
cp config/.gitconfig.local.example ~/.gitconfig.local
cp config/.zshrc.local.example ~/.zshrc.local
```

### `~/.gitconfig.local` 最小示例

```ini
[user]
    name = Your Name
    email = your-email@example.com
```

### `~/.zshrc.local` 最小示例

```bash
alias ll='ls -lah'
export EDITOR=vim
```
