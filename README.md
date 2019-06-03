# e-Streak
Eスポーツプレイヤーがゲームについての知識、戦略などを情報交換しあうwebサービスです。
転職活動用のポートフォリオとして制作致しました。

# テストユーザーログイン
- email: test@e-streak.com
- password: password

※観覧用としてご自由にお使いください

# リンク
- 本アプリ：https://e-streak.com/
- 機能紹介記事：

# 特に見ていただきたい部分
- Dockerを使いこなし、ECS/ECRで本番環境をコンテナで実行していること
- CircleCIとGitHubを連携させて自動テスト、masterブランチのみ本番環境にデプロイなど、CI/CDのパイプラインを構築していること
- assets及びユーザー画像データをS3からCloudFrontを使用してCDNで配信していること
- 自作ライブラリから外部APIを叩いてRailsに組み込んでいること

# クラウドアーキテクチャ
![クラウドアーキテクチャ](https://user-images.githubusercontent.com/47154781/58705772-20104080-83eb-11e9-9331-e504ef23e509.png)

# 使用技術
- Ruby 2.4.0
- Ruby on Rails 5.2.2
- MySQL 5.7.25
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
- 統合テスト(system spec)
- 機能テスト(request spec)
- 単体テスト(モデル等)
