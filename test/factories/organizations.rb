require 'ffaker'

FactoryGirl.define do
  factory :organization do
    # required
    name { FFaker::Lorem.words(rand(2..3)).join(' ').titleize }
    description { FFaker::Lorem.paragraph(rand(4..6))[0..399] }
    legal_form do
      Organization.enumerized_attributes.attributes['legal_form'].values.sample
    end
    charitable { FFaker::Boolean.maybe }
    completed { FFaker::Boolean.maybe }
    approved false

    # optional
    comment { maybe FFaker::Lorem.paragraph(rand(4..6))[0..399] }
    founded { maybe((1980..Time.now.year).to_a.sample) }
    umbrella do
      maybe(
        Organization.enumerized_attributes.attributes['umbrella'].values.sample
      )
    end

    # associations
    transient do
      website_count { rand(0..3) }
    end

    after :create do |orga, evaluator|
      create_list :hyperlink, evaluator.website_count, linkable: orga
    end

    # traits
    trait :approved do
      after :create do |orga, _evaluator|
        Organization.where(id: orga.id).update_all completed: true, approved: true, approved_at: Time.now
      end
      approved_by { FactoryGirl.create(:researcher).id }
    end
  end
end

def maybe result
  rand(2) == 0 ? nil : result
end
