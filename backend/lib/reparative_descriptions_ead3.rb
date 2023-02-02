class AspaceReparativeDescriptionsEAD3 < EAD3Serializer

  def serialize_aspace_reparative_descriptions(data, xml, fragments)
    if AppConfig[:plugins].include?('aspace_reparative_descriptions')
      if data.reparative_descriptions && data.reparative_descriptions.length > 0
        xml.send(AppConfig[:aspace_reparative_descriptions_note_type]) {
          xml.head {
            sanitize_mixed_content(I18n.t("reparative_description.section_title"), xml, fragments)
          }
          data.reparative_descriptions.each do |rd|
            xml.p {
              sanitize_mixed_content(AspaceReparativeDescriptionsHelper.assemble_reparative_description_text(rd), xml, fragments)
            }
            unless rd['description'].nil?
              xml.p {
                sanitize_mixed_content(rd['description'], xml, fragments)
              }
            end
          end
          }
      end
    end
  end

  def serialize_aspace_reparative_descriptions_for_digital_objects(digital_object, xml, fragments)
    if AppConfig[:plugins].include?('aspace_reparative_descriptions')
      if digital_object['reparative_descriptions'] && digital_object['reparative_descriptions'].length > 0
        xml.didnote {
          sanitize_mixed_content(I18n.t("reparative_description.section_title"), xml, fragments)
          digital_object['reparative_descriptions'].each do |rd|
            xml.lb {}
            sanitize_mixed_content(AspaceReparativeDescriptionsHelper.assemble_reparative_description_text(rd), xml, fragments)
            unless rd['description'].nil?
              xml.lb {}
              sanitize_mixed_content(rd['description'], xml, fragments)
            end
          end
        }
      end
    end
  end

end
