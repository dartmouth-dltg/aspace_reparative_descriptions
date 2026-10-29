# requires the content_warning_code enumeration and MARCModel#aspace_record
unless Array(AppConfig[:plugins]).include?('aspace_content_warnings')
  raise "aspace_reparative_descriptions requires the aspace_content_warnings plugin. " \
        "Add 'aspace_content_warnings' to AppConfig[:plugins]."
end

require_relative '../lib/reparative_descriptions_helper'
require_relative 'lib/reparative_descriptions_serializer'
require_relative 'lib/reparative_descriptions_ead'
require_relative 'lib/reparative_descriptions_ead3'
require_relative 'lib/reparative_descriptions_marc_serialize'

# allow for odd or processinfo as the EAD/EAD3 note type
if AppConfig.has_key?(:aspace_reparative_descriptions_note_type)
  unless ['odd', 'processinfo'].include?(AppConfig[:aspace_reparative_descriptions_note_type])
    AppConfig[:aspace_reparative_descriptions_note_type] = 'processinfo'
  end
else
  AppConfig[:aspace_reparative_descriptions_note_type] = 'processinfo'
end

# Set default MARC export libray code for 500
unless AppConfig.has_key?(:aspace_reparative_descriptions_org_code)
  AppConfig[:aspace_reparative_descriptions_org_code] = 'xxx'
end

# Register our custom serialize steps.
EADSerializer.add_serialize_step(EADAspaceReparativeDescriptionsSerialize)
EAD3Serializer.add_serialize_step(EAD3AspaceReparativeDescriptionsSerialize)
MARCSerializer.add_decorator(AspaceReparativeDescriptionsMARCSerialize)

