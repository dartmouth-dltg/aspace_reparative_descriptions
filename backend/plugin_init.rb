require_relative '../lib/reparative_descriptions_helper'
require_relative 'lib/reparative_descriptions_serializer'
require_relative 'lib/reparative_descriptions_ead'
require_relative 'lib/reparative_descriptions_ead3'
require_relative 'lib/reparative_descriptions_marc_serialize'

# allow for odd or scopecontent as the EAD/EAD3 note type
if AppConfig.has_key?(:aspace_reparative_descriptions_note_type)
  unless ['odd', 'proccessinfo'].include?(AppConfig[:aspace_reparative_descriptions_note_type])
    AppConfig[:aspace_reparative_descriptions_note_type] = 'processinfo'
  end
else
  AppConfig[:aspace_reparative_descriptions_note_type] = 'processinfo'
end

# Register our custom serialize steps.
EADSerializer.add_serialize_step(EADAspaceReparativeDescriptionsSerialize)
EAD3Serializer.add_serialize_step(EAD3AspaceReparativeDescriptionsSerialize)
MARCSerializer.add_decorator(AspaceReparativeDescriptionsMARCSerialize)

