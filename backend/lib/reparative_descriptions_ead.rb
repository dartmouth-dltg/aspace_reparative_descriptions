require 'aspace_logger'

class AspaceReparativeDescriptionsEAD < EADSerializer

  def serialize_aspace_reparative_descriptions(data, xml, fragments)
    if AppConfig[:plugins].include?('aspace_reparative_descriptions')
      if data.reparative_descriptions && data.reparative_descriptions.length > 0
        if AppConfig.has_key?(:aspace_reparative_descriptions_sort) && ['asc','desc'].include?(AppConfig[:aspace_reparative_descriptions_sort])
          reparative_descriptions = AspaceReparativeDescriptionsHelper.sort_reparative_descriptions(data.reparative_descriptions)
        end 
        xml.send(AppConfig[:aspace_reparative_descriptions_note_type]) {
          xml.head {
            sanitize_mixed_content(I18n.t("reparative_description.section_title"), xml, fragments)
          }
          reparative_descriptions.each do |rd|
            xml.p {
              sanitize_mixed_content(AspaceReparativeDescriptionsHelper.assemble_reparative_description_text(rd), xml, fragments)
            }
          end
          }
      end
    end
  end

  def serialize_aspace_reparative_descriptions_for_digital_objects(digital_object, xml, fragments)
    if AppConfig[:plugins].include?('aspace_reparative_descriptions')
      if digital_object['reparative_descriptions'] && digital_object['reparative_descriptions'].length > 0
        if AppConfig.has_key?(:aspace_reparative_descriptions_sort) && ['asc','desc'].include?(AppConfig[:aspace_reparative_descriptions_sort])
          reparative_descriptions = AspaceReparativeDescriptionsHelper.sort_reparative_descriptions(digital_object['reparative_descriptions'])
        end 
        xml.note {
          xml.p {
            sanitize_mixed_content(I18n.t("reparative_description.section_title"), xml, fragments)
          }
          reparative_descriptions.each do |rd|
            xml.p {
              sanitize_mixed_content(AspaceReparativeDescriptionsHelper.assemble_reparative_description_text(rd), xml, fragments)
            }
          end
        }
      end
    end
  end

end
