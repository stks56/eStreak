FactoryBot.define do
  factory :post do
    title { 'テストタイトル' }
    content { 'テストコンテンツ' }
    game
    user
  end
end
