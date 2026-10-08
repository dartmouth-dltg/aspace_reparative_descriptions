FactoryBot.define do

  factory :json_reparative_description_reason, class: JSONModel(:reparative_description_reason) do
    content_warning_code { "TEST" }
  end

  factory :json_reparative_description, class: JSONModel(:reparative_description) do
    reparative_description_date { generate(:yyyy_mm_dd) }
    description { generate(:alphanumstr) }
    reparative_description_reasons { rand(3).times.map { build(:json_reparative_description_reason).to_hash } }
  end

end
