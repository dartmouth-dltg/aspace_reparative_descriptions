require 'spec_helper'
require_relative 'factories'

describe "Aspace Reparative Descriptions" do

  let (:original_reparative_descriptions) { rand(3).times.map { |i| build(:json_reparative_description).to_hash }}

  before(:all) do
    enum_id = Enumeration[:name => "content_warning_code"].id

    unless EnumerationValue[:enumeration_id => enum_id,
                            :value => "TEST"]
      EnumerationValue.create(:enumeration_id => enum_id,
                              :value => "TEST",
                              :readonly => 0)
    end
  end

  it "supports creating an accession with some reparative descriptions" do
    acc = create_accession(:reparative_descrptions => original_reparative_descriptions)

    rds = Accession.to_jsonmodel(acc.id)['reparative_descriptions']

    rds.each_with_index do |rd, idx|

        rd['description'].should eq(original_reparative_descriptions[idx]['description'])
        rd['reparative_description_date'].should eq(original_reparative_descriptions[idx]['reparative_description_date'])

        rd['reparative_description_reasons'].each_with_index do |rdr, i|
            rdr['content_warning_code'].should eq(original_reparative_descriptions[idx]['reparative_description_reasons'][i]['content_warning_code'])
        end
    end
  end

  it "supports creating a resource with some reparative descriptions" do
    res = create_resource(:reparative_descrptions => original_reparative_descriptions)

    rds = Resource.to_jsonmodel(res.id)['reparative_descriptions']

    rds.each_with_index do |rd, idx|

        rd['description'].should eq(original_reparative_descriptions[idx]['description'])
        rd['reparative_description_date'].should eq(original_reparative_descriptions[idx]['reparative_description_date'])

        rd['reparative_description_reasons'].each_with_index do |rdr, i|
            rdr['content_warning_code'].should eq(original_reparative_descriptions[idx]['reparative_description_reasons'][i]['content_warning_code'])
        end
    end
  end

  it "supports creating an archival object with some reparative descriptions" do
    resource = create_resource({title: generate(:generic_title)})
    obj = create_archival_object({'resource' => { 'ref' => resource.uri }, :reparative_descrptions => original_reparative_descriptions})

    rds = ArchivalObject.to_jsonmodel(obj.id)['reparative_descriptions']

    rds.each_with_index do |rd, idx|

        rd['description'].should eq(original_reparative_descriptions[idx]['description'])
        rd['reparative_description_date'].should eq(original_reparative_descriptions[idx]['reparative_description_date'])

        rd['reparative_description_reasons'].each_with_index do |rdr, i|
            rdr['content_warning_code'].should eq(original_reparative_descriptions[idx]['reparative_description_reasons'][i]['content_warning_code'])
        end
    end
  end

  it "supports creating a digital object with some reparative descriptions" do
    dobj = create_digital_object(:reparative_descrptions => original_reparative_descriptions)

    rds = DigitalObject.to_jsonmodel(dobj.id)['reparative_descriptions']

    rds.each_with_index do |rd, idx|

        rd['description'].should eq(original_reparative_descriptions[idx]['description'])
        rd['reparative_description_date'].should eq(original_reparative_descriptions[idx]['reparative_description_date'])

        rd['reparative_description_reasons'].each_with_index do |rdr, i|
            rdr['content_warning_code'].should eq(original_reparative_descriptions[idx]['reparative_description_reasons'][i]['content_warning_code'])
        end
    end
  end

  it "supports creating a digital object component with some reparative descriptions" do
    dobj = create_digital_object({title: generate(:generic_title)})
    doc = create_digital_object_component({ 'digital_object' => { 'ref' => digital_object.uri }, :reparative_descrptions => original_reparative_descriptions})

    rds = DigitalObjectComponent.to_jsonmodel(doc.id)['reparative_descriptions']

    rds.each_with_index do |rd, idx|

        rd['description'].should eq(original_reparative_descriptions[idx]['description'])
        rd['reparative_description_date'].should eq(original_reparative_descriptions[idx]['reparative_description_date'])

        rd['reparative_description_reasons'].each_with_index do |rdr, i|
            rdr['content_warning_code'].should eq(original_reparative_descriptions[idx]['reparative_description_reasons'][i]['content_warning_code'])
        end
    end
  end

end