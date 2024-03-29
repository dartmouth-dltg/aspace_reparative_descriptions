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
      if AppConfig.has_key?(:aspace_reparative_descriptions_sort) && ['asc','desc'].include?(AppConfig[:aspace_reparative_descriptions_sort])
        reparative_descriptions = AspaceReparativeDescriptionsHelper.sort_reparative_descriptions(@record.aspace_record['reparative_descriptions'])
      end 
      reparative_descriptions.each do |rd|
        extra_fields << DataField.new('500', ' ', ' ', [SubField.new('a', AspaceReparativeDescriptionsHelper.assemble_reparative_description_text(rd)), SubField.new('5',AppConfig[:aspace_reparative_descriptions_org_code])])
      end
    end

    (@record.datafields + extra_fields).sort_by(&:tag)
  end

  def method_missing(*args)
    @record.send(*args)
  end
  
end
