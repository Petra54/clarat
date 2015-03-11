require 'ffaker'

FactoryGirl.define do
  factory :contact_person do
    name { Faker::NameDE.name }
    area_code_1 { maybe Faker.numerify('#' * rand(3..6)) }
    local_number_1 { area_code_1 ? Faker.numerify('#' * rand(7..11)) : nil }
    area_code_2 do
      (rand(2) == 0 && local_number_1) ? Faker.numerify('#' * rand(3..6)) : nil
    end
    local_number_2 { area_code_2 ? Faker.numerify('#' * rand(7..11)) : nil }
    email { maybe Faker::Internet.email }

    organization

    trait :no_fields do # careful, makes object non-valid
      name nil
      local_number_1 nil
      local_number_2 nil
      email nil
    end
  end
end