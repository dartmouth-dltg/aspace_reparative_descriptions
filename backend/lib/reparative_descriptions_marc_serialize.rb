require 'aspace_logger'

class AspaceReparativeDescriptionsMARCSerialize

  DataField = Struct.new(:tag, :ind1, :ind2, :subfields)
  SubField = Struct.new(:code, :text)
  
  def initialize(record)
    @record = record
  end


  def datafields
    extra_fields = []
    
    if @record.aspace_record['reparative_descriptions']
      @record.aspace_record['reparative_descriptions'].each do |rd|
        description = rd['description']
        rd_bp_description = AspaceReparativeDescriptionsHelper.assemble_reparative_description_text(rd)
        unless description.nil?
          rd_bp_description += ' ' + description
        end
        extra_fields << DataField.new('500', ' ', ' ', [SubField.new('a', rd_bp_description), SubField.new('5',AppConfig[:aspace_reparative_descriptions_org_code])])
      end
    end

    (@record.datafields + extra_fields).sort_by(&:tag)
  end

  def method_missing(*args)
    @record.send(*args)
  end
  
end
