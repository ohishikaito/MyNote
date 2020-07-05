FactoryBot.define do
  factory :tweet do
    title         { Faker::Lorem.word }
    text          { Faker::Lorem.word }
    image         { File.open("#{Rails.root}/app/assets/images/default.png") }
    created_at    { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    user
  end
end
