# Dotfiles

这里收纳的是我常用的配置。

## 包含内容

- [`Brewfile`](./Brewfile) —— 软件列表
- [`.zshrc`](./.zshrc) —— Shell 配置
- [`.gitconfig`](./.gitconfig) —— Git 默认配置
- [`starship.toml`](./starship.toml) —— Starship Prompt 配置
- [`mise.toml`](./mise.toml) —— 运行时版本定义
- [`ghostty/config`](./ghostty/config) —— 终端配置
- [`fastfetch/config.jsonc`](./fastfetch/config.jsonc) —— 启动信息展示配置
- [`install.sh`](./install.sh) —— 安装与部署脚本（默认 copy，可切换 link）
- [`.gitconfig.local.example`](./.gitconfig.local.example) —— Git 本地覆写示例
- [`.zshrc.local.example`](./.zshrc.local.example) —— Shell 本地覆写示例

## 本地覆写

如果需要加入自己的身份信息、别名或额外环境变量，先看 [`../docs/local-overrides.md`](../docs/local-overrides.md)。

## 目标路径

- [`.gitconfig`](./.gitconfig) → `~/.gitconfig`
- [`.zshrc`](./.zshrc) → `~/.zshrc`
- [`starship.toml`](./starship.toml) → `~/.config/starship.toml`
- [`mise.toml`](./mise.toml) → `~/.config/mise/config.toml`
- [`ghostty/config`](./ghostty/config) → `~/.config/ghostty/config`
- [`ghostty/config`](./ghostty/config) → `~/Library/Application Support/com.mitchellh.ghostty/config`（macOS）
- [`fastfetch/config.jsonc`](./fastfetch/config.jsonc) → `~/.config/fastfetch/config.jsonc`

## 使用

```bash
./install.sh
```

默认使用 **copy** 模式，把仓库内容复制到 Home 目录。

如果你想让 Home 配置实时跟随仓库文件变更，可改用 **link** 模式：

```bash
DOTFILES_INSTALL_MODE=link ./install.sh
# 或
./install.sh link
```
