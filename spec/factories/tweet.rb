FactoryBot.define do
  factory :tweet do
    title {"1"}
    text {"2"}
    created_at {Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    user
  end
end