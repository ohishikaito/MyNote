FactoryBot.define do
  factory :user do
    password =            Faker::Internet.password(min_length: 8)
    nickname              { Faker::Name.last_name }
    email                 { Faker::Internet.email }
    password              { password }
    password_confirmation { password }
    avatar                { File.open("#{Rails.root}/app/assets/images/default.png") }
  end
end
