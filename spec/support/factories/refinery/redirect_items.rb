
FactoryGirl.define do
  factory :redirect_item, :class => Refinery::Redirects::RedirectItem do
    sequence(:src_path) { |n| "refinery#{n}" }
  end
end

