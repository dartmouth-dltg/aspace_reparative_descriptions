class IndexerCommon

  add_indexer_initialize_hook do |indexer|
    if AppConfig[:plugins].include?('aspace_reparative_descriptions')
      indexer.add_document_prepare_hook {|doc, record|
        if ['accession','resource', 'archival_object', 'digital_object', 'digital_object_component'].include?(doc['primary_type']) && record['record']['reparative_descriptions']
          doc['reparative_descriptions_u_sbool'] = true
        end
      }
    end
  end

end
