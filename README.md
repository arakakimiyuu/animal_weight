# animal_weight

## サイト概要
動物の体重を記録するアプリ

## サイトカテゴリー
コミュニティサイト

### サイトテーマ
自分の飼っている動物の体重を記録するサービス。自分の飼っている動物の体重を振り返ったり、<br>
他のユーザの動物の体重を見ることができたりコメントすることができる。<br>

### テーマを選んだ理由
動物の体重を測ることで病気の早期発見することで動物の健康を守ることができ、
動物の健康状態を把握する上で必要な行為だということを知ってほしいため。

### ターゲットユーザ
・動物を飼っている人<br>
・動物が好きな人<br>
・動物関連の仕事についてる人

### 主な利用シーン
・動物の体重を測る時<br>
・動物の体調に変化があったときにふりかえる時<br>
・今後飼うかもしれない動物の体重を見る時

## 使い方
会員側のログインは新規登録で入力された名前、パスワードを入力することで使用できます。<br>
管理者のログインはメールアドレスを【animal0401@gmail.com】、パスワードは【Animal0401】で使用出来ます。<br>
会員側の場合、新規作成で好きなアカウントを作成しても利用が可能です。投稿する前にペット登録をする必要があります。<br>
投稿では動物の体重をグラフで確認することができます。<br>
検索フォームでは動物の種類,餌の種類を検索することができます。<br>
動物の種類を検索する場合はpetを選択、餌の種類を検索する場合はpostを選択する。<br>
管理者側の場合、会員を退会させたり、不適切な投稿,コメントを削除することができます。

## 設計書
テーブル定義書
https://docs.google.com/spreadsheets/d/1A547iJ_TOecifi7Bg7G4rWEI1nDWzc4Lb3fyOARCDm4/edit#gid=0<br>
ER図<br>
https://drive.google.com/file/d/1IQbQI8twh7atUB_U3W580nrGMIpG37WD/view?usp=sharing

## 機能一覧

#### 会員側の機能
・ゲストログイン機能
・会員機能
・投稿機能
・検索機能
・いいね機能
・コメント機能<br>
・いいね、コメント機能の非同期化
・ソート機能
・グラフ化

#### 管理者側の機能
・ユーザー管理機能
・コメント管理機能
・投稿管理機能

## バージョン
Rails 6.1.7 ruby 3.1.2

## インストール
$ cd animal_weight<br>
$ rails db:migrate<br>
$ rails db:seed<br>
$ bundle install<br>
$ yarn add chartkick chart.js

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 使用素材
ロゴデザイン<br>
https://ja.wix.com/logo/maker<br>
画像<br>
https://www.photo-ac.com/