# Rails Blog Application

[![Project Status: Active](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

大学生向けのシンプルなブログプラットフォームです。
Rails 7 + Propshaft + Importmap構成で、Node.js非依存のモダンな技術スタックを採用しています。

## 概要 (Overview)

本アプリケーションは、「大学生が学びや日常を手軽に記録・共有できる」ことを目的としたブログプラットフォームです。

開発プロセス（要件定義〜テスト）全体をドキュメント化し、最小限のJavaScriptで実現するImportmap/Propshaft構成を採用することで、自身の設計力とモダンな技術へのキャッチアップ能力を証明するポートフォリオとして開発しました。

## デモ環境 (Live Demo)

**URL:** https://rails-blog-application.onrender.com (デプロイ後に更新)

* **テスト用アカウント:**
    * **Email:** `test@example.com`
    * **Password:** `password`

## 機能一覧 (Features)

* **ユーザー認証機能 (Devise)**
    * 安全な新規登録、ログイン、ログアウト
    * パスワード再設定（メール送信機能付き）
* **記事投稿機能 (CRUD)**
    * ユーザーによる記事の作成、閲覧、更新、削除
    * 認可: 自身の記事のみ編集・削除可能
* **フォロー機能 (Relationships)**
    * 他のユーザーをフォロー / アンフォロー可能
    * フォロー中・フォロワー一覧表示
* **ページネーション機能 (Pagy)**
    * 記事一覧やユーザー一覧のパフォーマンスを考慮したページ分割表示

## 技術スタック (Tech Stack)

* **Backend:** Ruby 3.0.2, Rails 7.1.6
* **Database:** PostgreSQL
* **Frontend:** Bootstrap 5 (CDN), Importmap, Propshaft
* **Authentication:** Devise
* **Pagination:** Pagy
* **Deployment:** Render
* **Version Control:** Git, GitHub

## セットアップ (Setup)

### 前提条件

* Ruby 3.0.2以上
* PostgreSQL
* Git

### インストール手順

```bash
# リポジトリをクローン
git clone https://github.com/hduehgw0/rails-blog-application.git
cd rails-blog-application

# 依存関係をインストール
bundle install

# データベースをセットアップ
rails db:create db:migrate db:seed

# サーバーを起動
rails server
```

ブラウザで http://localhost:3000 にアクセスしてください。

## デプロイ (Deployment)

### Renderへのデプロイ手順

1. Renderアカウントを作成
2. 新しいWeb Serviceを作成
3. GitHubリポジトリを接続
4. 環境変数を設定:
   - `RAILS_MASTER_KEY`: `config/master.key`の内容
   - `SMTP_USERNAME`: メール送信用のGmailアドレス
   - `SMTP_PASSWORD`: Gmailアプリパスワード
5. デプロイを実行

## 開発ドキュメント

本プロジェクトは以下のドキュメントに基づいて開発されました:

1. 要件定義書
2. 機能仕様書・画面仕様書
3. データ設計（ER図・スキーマ定義）
4. ルーティング設計・API設計
5. テスト設計書
6. タスク分割とスケジューリング

## 今後の改善予定

* 画像アップロード機能（Active Storage）
* いいね機能
* コメント機能
* 検索機能
* タグ機能

## ライセンス

MIT License

## 作者

西脇 光平 (Kohei Nishiwaki)
* GitHub: [@hduehgw0](https://github.com/hduehgw0)
