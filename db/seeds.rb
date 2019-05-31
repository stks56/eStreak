# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
  name: 'e-Streak',
  email: 'estreak@e-streak.com',
  password: 'estreak'
)

User.create!(
  name: 'テストユーザー',
  email: 'test@e-streak.com',
  password: 'password'
)

AdminUser.create!(
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password'
) if Rails.env.development?

Game.create!(name: 'League of Legends')
GameImage.create!(
  game_id: 1,
  icon_image: File.open('./db/data/game_image/icon_image/1.jpg'),
  background_image: File.open('./db/data/game_image/background_image/1.jpg')
)

Game.create!(name: 'APEX Legends')
GameImage.create!(
  game_id: 2,
  icon_image: File.open('./db/data/game_image/icon_image/2.jpg'),
  background_image: File.open('./db/data/game_image/background_image/2.jpg')
)

Game.create!(name: "PLAYERUNKNOWN'S BATTLEGROUNDS")
GameImage.create!(
  game_id: 3,
  icon_image: File.open('./db/data/game_image/icon_image/3.jpg'),
  background_image: File.open('./db/data/game_image/background_image/3.jpg')
)

Game.create!(name: 'Fortnite')
GameImage.create!(
  game_id: 4,
  icon_image: File.open('./db/data/game_image/icon_image/4.jpg'),
  background_image: File.open('./db/data/game_image/background_image/4.jpg')
)

Game.create!(name: 'Hearthstone')
GameImage.create!(
  game_id: 5,
  icon_image: File.open('./db/data/game_image/icon_image/5.jpg'),
  background_image: File.open('./db/data/game_image/background_image/5.jpg')
)

Post.create!(
  title: "League of Legendsとは",
  content: "League of Legends（リーグ・オブ・レジェンド）は、アメリカ合衆国のゲーム会社Riot Games（ライアットゲームズ）が開発したWindows、macOS用のマルチプレイヤーオンラインバトルアリーナ(MOBA)型の基本プレイ無料ゲームである。略称：LoL/ロル。\r\n多くのゲームレビューサイトなどで高評価を得ており、2012年、世界で最もプレイヤー数の多いPCゲームとされている。 米国ではプロスポーツ選手用のビザが認定されるなど、プロゲーマーが競い合うエレクトロニック・スポーツの種目としても注目されている。\r\n日本語版のオープンβテストは2016年3月1日に開かれた。\r\n日本語版のオープンβから1周年となる2017年3月1日より正式版のサービスが開始された。\r\n\r\nプレーヤーは3対3あるいは5対5の2つのチームに分かれ、各プレイヤーが使用するチャンピオンを選択、ネクサスと呼ばれるお互いの本拠地を破壊することを目指す。チャンピオンは100種類を超えており、現在でも定期的に追加されている。ただし、全てのチャンピオンが使えるわけではなく、毎週変わる無料で使えるチャンピオンか、後述するBEかRPを消費して解除したチャンピオンしか選択することはできない。\r\nネクサスを破壊するために、レーンと呼ばれた道に沿って配置されている塔を破壊しながら進軍することになる。しかし、塔からは非常に強力な攻撃を受けてしまうため、ミニオンと呼ばれるネクサスから定期的に発生するNPCを楯にして塔に攻撃をする必要がある。また、ミニオンや敵チャンピオンを倒すことによって、チャンピオンを強化することができる経験値やお金を入手することができる。最終的にゲームに勝利するためには、効率的にミニオンを倒す、強襲して敵チャンピオンを倒すなどして自チームのチャンピオンを強化していくことが重要となる。\r\n\r\nwikipedeaより引用",
  game_id: 1,
  user_id: 1
)

Post.create!(
  title: "APEX Legendsとは",
  content: "『エーペックスレジェンズ』（英: Apex Legends）は、エレクトロニック・アーツが2019年2月5日に配信開始した基本プレイ無料のコンピュータゲームソフト。\r\n対応プラットフォームは、PlayStation 4、Xbox One、PC。\r\n\r\n『タイタンフォール』シリーズの作品だが、巨大ロボット「タイタン」は登場せず、「レジェンド」と呼ばれる特殊能力者たちが戦うバトルロイヤルゲームとなっている。『タイタンフォール2』の30年後の世界で、辺境の惑星の「エーペックスゲーム」に参加する。\r\nレジェンズと呼ばれる特殊能力者3人で1チームとなり、全20チーム、合計60人でのオンライン対戦が可能。徐々に狭くなるフィールドを探索してアイテムを回収しつつ、敵チームを倒し、最後の1チームになると勝利。\r\n配信開始から72時間でプレイヤー数が1000万人を超え、エレクトロニック・アーツの株価が大幅に上昇するといった影響を与えた。\r\n\r\nwikipedeaより引用",
  game_id: 2,
  user_id: 1
)

Post.create!(
  title: "PLAYERUNKNOWN'S BATTLEGROUNDSとは",
  content: "『PLAYERUNKNOWN'S BATTLEGROUNDS』（プレイヤーアンノウンズ バトルグラウンズ、略称：PUBG）は、韓国のデベロッパーBlueholeの子会社であるPUBG Corporationが開発しているバトルロイヤルゲーム。\r\n2017年3月24日にSteamで早期アクセス版の配信が開始され、2017年12月20日（日本時間では2017年12月21日）に正式版としてリリースされた。\r\nXbox One版は2017年12月12日にプレビュー版が発売された。Xbox One版パッケージ版も販売されているが、ディスクメディアではなく紙箱にダウンロードカードが入る形となっている。\r\n2018年5月16日に日本でもiOSとAndroid版の「PUBG MOBILE」の配信を開始した。\r\nPlayStation 4版は2018年12月7日から配信開始。『アンチャーテッド』シリーズのネイサンのコスチュームや『ラストオブアス』のエリーのバックパックなどの追加要素がある。2019年1月17日からはパッケージ版も発売予定。\r\n\r\n最大100人のプレイヤーが、フィールド内にある装備などを駆使して最後の1人になるまで戦い抜くバトルロイヤル形式のサードパーソン・シューティングゲーム（ファーストパーソン・パースペクティブ（FPP）モードも追加された）であり、ストーリーも存在しない。熾烈な激闘に勝ち抜き、見事第1位を勝ち取ったとき、日本語版では「勝った! 勝った! 夕飯はドン勝だ!!」と画面に表示される（英語版ではWINNER WINNER CHICKEN DINNER!との表示）。また、2人タッグや（最大）4人スクワッドでのチーム戦モードも用意されている。\r\n『ARMA 3』のMODの製作者で、「PlayerUnknown」というハンドルネームで知られるブレンダン・グリーン（Brendan Greene）をクリエイティブ・ディレクターに迎えて開発されている。\r\n\r\nwikipedeaより引用",
  game_id: 3,
  user_id: 1
)

Post.create!(
  title: "Fortniteとは",
  content: "『フォートナイト』（Fortnite）は、Epic Games（エピックゲームズ）が販売・配信するアクションビルディングゲーム、サードパーソン・シューティング、バトルロイヤルゲーム。\r\n対応プラットフォームはPC（Windows/macOS）、PlayStation 4、Xbox One、Nintendo Switch、iOS、Android。iOS版はApp Storeから、Android版は、Google Playストアではなく、Epic Gamesが運営する自社サイトにて配信されている。またAndroid版は、2018年8月9日より一部端末向けにベータ版がリリースされ、その他の機種へも順次拡大中である。\r\nプラットフォームに制限はあるが購入することでプレイできる「世界を救えモード」と、全てのプラットフォームで無料プレイ可能な「バトルロイヤル」モードと、島を作ることが可能な「クリエイティブ」モードが有る。\r\n\r\n集めた素材で壁や坂を作るなど、クラフト要素のあるサードパーソン・シューティングゲームで、オンラインでの対人（PvP）とCO-OPモード（PvE）もある。なお世界を救えモードの無料プレイローンチは2018年を予定していたが延期が発表された。2018年2月に有料版同封や無料配信されたバトルロイヤルモードは、同時接続プレイヤーが同月に340万人、同年11月に830万人に達した。2019年2月に開催された「Marshmello」コラボイベントでは、1000万人を超えるプレイヤーが同時に接続した。基本無料だが、スキン（プレイヤーキャラクターの外見変更アイテム）や追加パックの販売で収益を得ており、2018年4月の月間売上は2億9600万ドル（約325億円）に達し、欧米では「社会現象」になっていると報道された。\r\n課金アイテムである「Vinderbucks」略称「V-Bucks」は各モード共通で利用でき、ゲーム内で使用できるコスチュームアイテムやエモート等の購入に使用できる。\r\n\r\nwikipedeaより引用",
  game_id: 4,
  user_id: 1
)

Post.create!(
  title: "Hearthstoneとは",
  content: "ハースストーン（Hearthstone） はブリザード・エンターテイメントが開発したコレクティブルカードゲーム(CCG)。2013年の3月にPenny Arcade Expoにて発表され、2014年3月11日にリリースされた。\r\nリリース当初の名称は『Hearthstone: Heroes of Warcraft』であった。ウォークラフトシリーズの世界観を背景とした、トレーディングカードゲームである。基本プレイは無料でアイテム課金が存在するが、課金により得られるポイントとゲーム中のクエスト達成で得られるポイントは同一の物である。2015年には2500万アカウントを記録した。\r\nリリース当初は日本語に対応していなかったが、2015年10月3日に秋葉原で開催されたイベントで日本語対応を発表、同年10月21日（日本時間）に実施されたクライアントアップデートで日本語が追加された。\r\nゲームはPCやスマートフォンなど様々な媒体で展開されているが、各カードはBattle.netアカウント毎に管理されている為、同一のBattle.netアカウントでログインすれば媒体問わず同じ状態でゲームプレイが可能である。\r\n\r\nwikipedeaより引用",
  game_id: 5,
  user_id: 1
)
