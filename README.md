# MyNote

# アプリ概要
就職活動用のポートフォリオとして開発した個人アプリです。
人見知りの人に改善する方法を提案したり、独自のタグをつけて意見の投稿ができるアプリです。

- ユーザー登録することで記事を投稿・編集・削除できる
- 投稿に対していいね、コメント、寄付で反応ができる機能を実装
- ユーザー間のコミュニケーションを促すために、フォロー・通知・DM機能を実装

# 本番環境
https://mynote.world/

ゲストユーザーとしてログインすることができます。

# このアプリを開発した背景
**「変わるきっかけ」を作れたら、と言う想いでこちらのアプリを開発しました。**

私は1年前会話がとても苦手で、いわゆる人見知りでした。
変わりたいと思っても何をしていいか分からず行動できませんでした。

そんな時に、[Noteというプラットフォーム](https://note.com/)を知り、元人見知りの人が改善した方法をまとめた投稿を見つけました。
私は「これだ！」と直感して、その人の方法を実践した結果、自分の性格がみるみる変わっていくのを実感しました。

人見知りを改善したことで、新しいことに臆せず挑戦できるようになったり、初対面の人とコミュニケーションを取るのが楽しい。と思うようになり、人生の満足度が格段に上がりました。

ですので、今度は自分と同じ人見知りを改善したいと思ってる人に、「変わるきっかけ」を作れたら、と思います。

# 実際のアプリの動画
![sample](https://user-images.githubusercontent.com/61116343/86710699-35c45080-c056-11ea-9b3d-47b2d922ed63.gif)
![ttt](https://user-images.githubusercontent.com/61116343/86717276-fbaa7d00-c05c-11ea-85f5-b7b1b1a2f585.gif)


## 工夫したポイント
* 開発環境にDocker、CircleCIを用いた自動テスト、デプロイを導入しました。
* 主要機能を非同期通信で実装しました。
* デザインを統一して直感的に分かりやすいレイアウトを意識しました。

## 課題や今後実装したい機能
* パンくず機能の実装
* AWSのECSやECRを使った本番環境のコンテナ化
* 通知機能の範囲の拡大
* 画像の複数投稿対応
* タグ登録時の利便性向上

## 使用技術
* Ruby 2.5.1, Rails 5.2.4.2
* Puma（開発環境）
* Nginx、unicorn（本番環境）
* MySQL
* SCSS, JavaScript（jQuery）
* RSpec
* Docker
* CircleCI CI/CDパイプラインを構築
* Capistrano
* AWS （EC2, RDS for MySQL, S3, VPC, Route53, ALB, ACM）

## AWS構成図
![MyNote AWS構成図](https://user-images.githubusercontent.com/61116343/95417165-4b0b8c80-096f-11eb-9d50-ed260078dc87.png)

# 機能一覧
- ユーザー機能
- 管理者権限
- 記事機能
- タグ付け機能
- 寄付機能
- コメント機能
- いいね機能
- フォロー機能
- ページネーション機能
- 検索機能
- ダイレクトメッセージ機能
- 通知機能
- 活動履歴の保存機能

## ユーザー機能
  - deviseを使用
  - 新規登録、ログイン、ログアウト、編集機能
  - かんたんログイン機能
  - 管理者ユーザー機能
  - ユーザーの一覧表示

## 記事機能
  - 記事一覧表示、記事詳細表示、記事投稿、記事編集、記事削除機能
  - 画像のアップロードはcarrierwaveというgemを使用
  - プレビュー機能
  - マークダウン記法対応

## ページネーション機能
  - kaminariというgemを使用

## タグ付け機能
  - acts_as_taggableというgemと、jQueryプラグインのtag-itを使用
  - 記事に複数のタグをつけられる機能
  - タグ名は自由に入力可能（自動補完機能付き）

## 寄付機能（非同期）
  - 記事に数字を入力して寄付ができる機能

## コメント機能（非同期）
  - 記事ごとのコメント表示、コメント投稿、コメント編集、コメント削除機能

## いいね機能（非同期）
  - 記事にいいねした人の一覧表示
  - ユーザーがいいねした記事の一覧表示
  - 人気順表示機能

## フォロー機能（非同期）
  - フォロー、フォロワー一覧表示機能
  - タイムライン機能

## 検索機能
  - 投稿記事の内容を検索
  - タイトルと本文の曖昧検索

## ダイレクトメッセージ機能
  - 1：1のチャットルームを作成
  - メッセージ送信、メッセージ削除機能（非同期）

## 通知機能
  - いいね、コメント、フォロー、ダイレクトメッセージを受信したら通知
  - 未読通知があるとお知らせを表示

## 活動履歴の保存機能
  - いいね、コメント、フォロー、ダイレクトメッセージを送信した履歴を確認可能

## テスト機能
  - RSpecを使用（テスト数は100以上）



## DB設計
<img width="1241" alt="70f4485f173d3d889da434b5ce52faf7" src="https://user-images.githubusercontent.com/61116343/85198895-cc8ad080-b326-11ea-9f81-68be47d1f8a9.png">
