# My-Mac-Dotfiles

[English](./README.en.md)

这是一些常用的配置和软件清单。

## 目录

- [`config/`](./config/) —— 常用配置
- [`docs/applications.md`](./docs/applications.md) —— 常用软件清单
- [`docs/local-overrides.md`](./docs/local-overrides.md) —— 本地覆写说明
- [`bootstrap.sh`](./bootstrap.sh) —— 安装入口
- [`scripts/check.sh`](./scripts/check.sh) —— 简单检查脚本

## 最小上手

1. 先准备好 `brew`
2. 执行 `./bootstrap.sh`
3. 如需加入自己的身份信息或别名，参考 [`docs/local-overrides.md`](./docs/local-overrides.md)
4. 最后执行 `./scripts/check.sh`

```bash
./bootstrap.sh
```

## 检查

```bash
./scripts/check.sh
```
