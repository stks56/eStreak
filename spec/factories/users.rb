FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { 'test1@exmple.com' }
    password { 'password' }
  end
end
