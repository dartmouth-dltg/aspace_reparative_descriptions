require 'aspace_logger'

class EADAspaceReparativeDescriptionsSerialize < EADSerializer

  def call(data, xml, fragments, context)
    acw_ead = AspaceReparativeDescriptionsEAD.new

    if context == :archdesc
      acw_ead.serialize_aspace_reparative_descriptions(data, xml, fragments)
    end

    if context == :dao
      acw_ead.serialize_aspace_reparative_descriptions_for_digital_objects(data, xml, fragments)
    end
  end

end

class EAD3AspaceReparativeDescriptionsSerialize < EAD3Serializer

  def call(data, xml, fragments, context)
    acw_ead3 = AspaceReparativeDescriptionsEAD3.new

    if context == :archdesc
      acw_ead3.serialize_aspace_reparative_descriptions(data, xml, fragments)
    end

    if context == :dao
      acw_ead3.serialize_aspace_reparative_descriptions_for_digital_objects(data, xml, fragments)
    end
  end

end