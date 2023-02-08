require 'factory_girl'

FactoryGirl.define do

  factory :json_reparative_description_reason, class: JSONModel(:reparative_description_reason) do
    content_warning_code { "TEST" }
  end

  factory :json_payment_summary, class: JSONModel(:payment_summary) do
    reparative_description_date { generate(:yyyy_mm_dd) }
    description { generate(:alphanumstr) }
    reparative_description_reasons { rand(3).times.map {|i| build(:json_reparative_description_reason).to_hash} }
  end

end