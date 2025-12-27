# github-actions-act
GitHub Actions をローカルで挙動確認するためのツール act の検証

## セットアップ
- Docker が動作すること（act は内部でコンテナを使います）
- act をインストールする: https://github.com/nektos/act

このリポジトリには `act` 用のデフォルト設定として `.actrc` を置いてあります（`ubuntu-latest` を互換イメージにマップ）。

## 何が入っている？
- `.github/workflows/ci.yml`: push/PR/手動実行で動くスモークテスト
- `.github/scripts/hello.sh`: ワークフローから呼ぶ簡単なスクリプト

## 実行例（WSL bash）
```bash
# pushイベント相当で実行
act push

# PRイベント相当で実行
act pull_request

# workflow_dispatch（手動実行）相当で実行
act workflow_dispatch

# 詳細ログ
act push -v

# .actrc を使わずにイメージを明示したい場合
act push -P ubuntu-latest=catthehacker/ubuntu:act-latest
```

実行すると、
- リポジトリのチェックアウト
- 簡単な環境情報の出力
- `dist/hello.txt` の生成
- artifact アップロード（act上でも動作確認用途）

までが走ります。

## よくある注意点
- `ubuntu-latest` は GitHub のホストランナーと完全に同一ではないので、`-P` でイメージを固定するのがおすすめです（このリポジトリは `.actrc` で設定済み）。
- GitHub API を叩く処理などは `GITHUB_TOKEN` が必要になる場合があります。その場合は `act -s GITHUB_TOKEN=...` のように secret を渡します。
- ARM 環境などでイメージ互換性に問題が出る場合は `--container-architecture linux/amd64` が必要になることがあります。
