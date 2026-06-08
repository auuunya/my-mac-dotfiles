#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "==> Checking shell files"
bash -n config/install.sh
zsh -n config/.zshrc

echo "==> Checking application stats"
python3 - <<'PY'
from pathlib import Path
import re

text = Path('docs/applications.md').read_text(encoding='utf-8')
lines = text.splitlines()

app_count = sum(1 for line in lines if line.startswith('- **') and line.endswith('**'))
category_count = sum(1 for line in lines if line.startswith('## ') and any(ch in line for ch in '🛠️⚡🌐🔐🎬🤖🧭📸📱🔋'))

total_match = re.search(r'- 总数：\*\*(\d+)\*\* 个应用', text)
category_match = re.search(r'- 分类：\*\*(\d+)\*\* 类', text)

if not total_match or not category_match:
    raise SystemExit('missing declared stats in docs/applications.md')

declared_app_count = int(total_match.group(1))
declared_category_count = int(category_match.group(1))

if app_count != declared_app_count:
    raise SystemExit(f'application count mismatch: declared {declared_app_count}, actual {app_count}')

if category_count != declared_category_count:
    raise SystemExit(f'category count mismatch: declared {declared_category_count}, actual {category_count}')

print('application stats check passed')
PY

echo "==> Checking wording"
python3 - <<'PY'
from pathlib import Path

root = Path('.')
keywords = [
    bytes.fromhex('6d61636f73').decode(),
    bytes.fromhex('4d61634f53').decode(),
    bytes.fromhex('6d61634f53').decode(),
    bytes.fromhex('4d61636f73').decode(),
    ''.join(chr(x) for x in (26412, 26426)),
    ''.join(chr(x) for x in (26426, 22120)),
    ''.join(chr(x) for x in (23487, 20027, 26426)),
]
failed = []
for path in sorted(root.rglob('*')):
    if not path.is_file() or '.git/' in str(path):
        continue
    try:
        text = path.read_text(encoding='utf-8')
    except Exception:
        continue
    for kw in keywords:
        if kw in text:
            failed.append((str(path), kw))
if failed:
    for path, kw in failed:
        print(f'{path}: {kw}')
    raise SystemExit(1)
print('wording check passed')
PY

echo "==> Done"
