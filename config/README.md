# Dotfiles

这里收纳的是我常用的配置。

## 包含内容

- [`Brewfile`](./Brewfile) —— 软件列表
- [`.zshrc`](./.zshrc) —— Shell 配置
- [`.gitconfig`](./.gitconfig) —— Git 默认配置
- [`mise.toml`](./mise.toml) —— 运行时版本定义
- [`ghostty/config`](./ghostty/config) —— 终端配置
- [`fastfetch/config.jsonc`](./fastfetch/config.jsonc) —— 启动信息展示配置
- [`install.sh`](./install.sh) —— 安装与链接脚本
- [`.gitconfig.local.example`](./.gitconfig.local.example) —— Git 本地覆写示例
- [`.zshrc.local.example`](./.zshrc.local.example) —— Shell 本地覆写示例

## 本地覆写

如果需要加入自己的身份信息、别名或额外环境变量，先看 [`../docs/local-overrides.md`](../docs/local-overrides.md)。

## 使用

```bash
./install.sh
```
