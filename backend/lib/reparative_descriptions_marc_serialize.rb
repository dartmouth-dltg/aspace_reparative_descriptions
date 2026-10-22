# MARCModel#aspace_record (the source record) is provided by the required
# aspace_content_warnings plugin (backend/lib/aspace_patches.rb); core 4.2.1 has none.

class AspaceReparativeDescriptionsMARCSerialize

  DataField = Struct.new(:tag, :ind1, :ind2, :subfields)
  SubField = Struct.new(:code, :text)

  def initialize(record)
    @record = record
  end

  def datafields
    # call through, not respond_to?: other plugins' decorators may wrap @record
    # with only method_missing, which would hide aspace_record from respond_to?
    source = @record.aspace_record
    rds = source && source['reparative_descriptions']
    extra_fields = AspaceReparativeDescriptionsHelper.sort_reparative_descriptions(rds).map do |rd|
      DataField.new('500', ' ', ' ', [
        SubField.new('a', AspaceReparativeDescriptionsHelper.assemble_reparative_description_text(rd)),
        SubField.new('5', AppConfig[:aspace_reparative_descriptions_org_code])
      ])
    end

    (@record.datafields + extra_fields).sort_by(&:tag)
  end

  def method_missing(*args, &block)
    @record.send(*args, &block)
  end

  def respond_to_missing?(name, include_private = false)
    @record.respond_to?(name, include_private) || super
  end

end
