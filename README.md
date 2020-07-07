# MyNote

## 概要
就職活動用のポートフォリオとして開発した自作アプリです。<br />
自由な意見に画像とタグを追加して投稿できます。
開発環境にDocker、CircleCIによるCI/CDパイプラインを構築、インフラにはAWSを使用しています。

# 本番環境
https://mynote.world/
* ゲストユーザーとしてログインすることができます。

# 制作背景
* 「変わるきっかけ」を作れたら、と言う想いでこちらのアプリを開発しました
<br />
自分は1年前会話がとても苦手で、いわゆる人見知りでした。<br />
変わりたいと思っても行動できず、そんな時にNoteというプラットフォームを知り、人見知りを改善した方法をまとめた投稿を見つけました。<br />
直感で「これだ」と感じ、その人の方法を実践した結果、自分の性格変わっていくのを実感しました。<br />
自分と同じ人見知りを改善したいと思ってる人に「変わるきっかけ」を作れたら、と思います。

# デモ
![sample](https://user-images.githubusercontent.com/61116343/86710699-35c45080-c056-11ea-9b3d-47b2d922ed63.gif)


## 工夫したポイント
* 開発環境にDocker、CircleCIを用いた自動テスト、デプロイを導入しました。
* 主要機能を非同期通信で実装しました。
* デザインを統一して直感的に分かりやすいレイアウトを意識しました。

## 課題や今後実装したい機能
* パンくず機能を実装します。
* AWSのECSやECRに興味があるので、そちらも挑戦していきたいです。
* 通知機能の範囲の拡大
* 画像の複数投稿対応
* タグ登録時の利便性向上

## 使用技術（開発環境）
* Ruby 2.5.1, Rails 5.2.4
* Nginx, unicorn, Puma
* MySQL
* Sass, jQuery
* RSpec
* Docker
* CircleCI CI/CD
* Capistrano
* AWS (EC2, RDS for MySQL, S3, VPC, Route53, ALB, ACM)

## 機能一覧
- ユーザー機能
  - deviseを使用
  - 新規登録、ログイン、ログアウト、編集機能
  - かんたんログイン機能
  - 管理者ユーザー機能
  - ユーザーの一覧表示
- 記事関係
  - 記事一覧表示、記事詳細表示、記事投稿、記事編集、記事削除機能
  - 画像のアップロードはcarrierwaveを使用
  - プレビュー機能
  - マークダウン記法対応
- タグ付け機能
  - acts_as_taggableと、jQueryプラグインのtag-itを使用
  - 記事に複数のタグをつけられる機能
  - タグ名は自由に入力可能（自動補完機能付き）
- 寄付機能（非同期）
  - 記事に数字を入力して寄付ができる機能
- コメント機能（非同期）
  - 記事ごとのコメント表示、コメント投稿、コメント編集、コメント削除機能
- ページネーション機能
  - kaminariを使用
- いいね機能（非同期）
  - 記事にいいねした人の一覧表示
  - ユーザーがいいねした記事の一覧表示
  - 人気順表示機能
- フォロー機能（非同期）
  - フォロー、フォロワー一覧表示機能
  - タイムライン機能
- 検索機能
  - 投稿記事の内容を検索
  - タイトルと本文の曖昧検索
- テスト機能
  - RSpecを使用
- ダイレクトメッセージ機能
  - 1：1のチャットルームを作成
  - メッセージ送信、メッセージ削除機能（非同期）
- 通知機能
  - いいね、コメント、フォロー、ダイレクトメッセージを受信したら通知
  - 未読通知があるとお知らせを表示
- 自分の活動記録を保存
  - いいね、コメント、フォロー、ダイレクトメッセージを送信した履歴を確認可能


## DB設計
<img width="1241" alt="70f4485f173d3d889da434b5ce52faf7" src="https://user-images.githubusercontent.com/61116343/85198895-cc8ad080-b326-11ea-9f81-68be47d1f8a9.png">
