# e-Streak
eスポーツプレイヤーがゲームについての知識、戦略などを情報交換しあうwebサービスです。
転職活動用のポートフォリオとして制作致しました。

![TOP画面](https://user-images.githubusercontent.com/47154781/58903541-a9ec4080-8740-11e9-8f59-56733b44169a.png)

# テストユーザーログイン
- email: test@e-streak.com
- password: password

※観覧用としてご自由にお使いください

# リンク
- 本アプリ：https://e-streak.com/

# 特に見ていただきたい部分
- Dockerを使いこなし、ECS/ECRで本番環境をコンテナで実行していること
- CircleCIとGitHubを連携させて自動テスト、masterブランチのみ本番環境にデプロイなど、CI/CDのパイプラインを構築していること
- assets及びユーザー画像データをS3からCloudFrontを使用してCDNで配信していること
- 自作ライブラリから外部APIを叩いてRailsに組み込んでいること

# 使用技術
- Ruby 2.4.0
- Ruby on Rails 5.2.2
- MySQL 5.7.25
- SASS
- AWS
  - ECS/ECR
  - EC2/ALB
  - RDS for MySQL
  - S3
  - CloudFront
  - SES
  - Route53
  - Certificate Manager
  - VPC
  - CloudWatch
- Docker
- CircleCI
  - ecs-deploy
- GitHub

# クラウドアーキテクチャ
[![クラウドアーキテクチャ](https://user-images.githubusercontent.com/47154781/58918750-9522a380-8766-11e9-9285-9f1177ad5af3.png)](https://e-streak.com/)

CricleCIからESRにpushした[本番環境用イメージ](/Dockerfile_PRO)を使い、ECSのEC2インスタンスタイプでデプロイしています。
webサーバー等は使わずアプリケーションサーバー(puma)のみを使い、ALBでリクエストの分配を行っています。
ALBではHTTPからHTTPSへのリダイレクトをしており、常時SSL化を実現しています。

assets及び画像ファイルはRailsからS3に保存、S3からCloudFrontでCDN配信を行っています。

データベースにはRDS、メール配信システムにはSESを採用。

GitHub上では可視化されませんが、AWSではVPC内のセキュリティグループやIAMユーザーポリシーなどの設定を出来るだけ細かく行い、実際の現場でのアーキテクチャを想定して構成されています。

尚、アプリ内の秘匿情報等はRailsのcredentialsを活用し、マスターキーをCircleCIとECSのコンテナ定義の環境変数に登録することで一元管理しています。

# 開発環境
MacBookPro上のDocker環境で開発しています。
[開発環境用イメージ](/Dockerfile)とそれらを起動する[docker-compose](/docker-compose.yml)で構成されています。
docker-composeでVolumeをマウント、MySQLに関してもローカルのMySQLをマウントしています。

GitHubは実際の現場の開発フローを想定しmasterブランチに直接pushせず、worksという作業用のブランチを切ってそこにPush、Masterにmergeしています。

# CircleCI
CircleCIではworksではRSpecでのテスト、masterブランチではRSpecでのテストとECRへイメージのpush、ECSへの自動デプロイを行っています。
CircleCIの設定は[.ciecleci/config.yml](/.circleci/config.yml)を見て頂けるとわかるかと思います。
ECSへのデプロイには[ecs-deploy](https://github.com/silinternational/ecs-deploy)というツールを使用しています。

最終的にmasterにmergeされてからデプロイされるまでの時間はこのようになりました。
![CircleCIワークフロー](https://user-images.githubusercontent.com/47154781/58921133-614c7b80-8770-11e9-8326-24a70688241a.png)

# 機能一覧、使用した有名gem
- ユーザー登録、ログイン機能全般、パスワードを忘れた際のメール配信(devise)
- Twitter、Twitchでの外部サービスログイン(omniauth)
- ユーザープロフィール画像アップロード機能
- ユーザー間でのフォローフォロワー機能
- 記事投稿機能(CRUD)
- 記事一覧表示の際のページネーション機能(kaminari)
- 外部API(Twitch)を叩いてコンテンツを表示
- 人気記事ランキング表示機能
- いいね機能
- 管理画面(ActiveAdmin)

# テスト
- RSpec
  - 統合テスト(system spec)
  - 機能テスト(request spec)
  - 単体テスト(モデル等)

テストに関しましてはテストが書けることをアピールする為、全ての機能はテストしていません。
その代わりどのようなテストケースでも書けることを意識しました。

# 改善点、開発してみて想定できなかった部分
- issueにもありますが結構解決できてないbugが結構あります。
- Dockerfileが重すぎる、pushやbuildに時間がかかりすぎているので軽量化したい。

Alpine Linuxを使っているRubyイメージが公式にあるのでそれを使えば軽くなりそう。apt-get updateで入るnodeのバージョンが低く手動でアップデートしているのでその辺も解決できそう
- CSSフレームワークを使用するべきだった。

設計段階ではBootstrapも視野に入れていたが、Bootstrap臭さがどうしても残る為オリジナルのデザインにしたかった。
実際書いて見るとSASSを使っているにしてもCSSのコーディングに想定以上に時間が掛かってしまった。
バックエンドエンジニアを目指しているのでフロントエンド面は簡潔にするべきだった。
- インフラ等の非機能要件は充実しているが、それに比べ実際のアプリの機能面で見るとチープに見えてしまいポートフォリオとしてのインパクトが欠けてしまったように思える。
