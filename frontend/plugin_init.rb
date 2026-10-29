require_relative '../lib/reparative_descriptions_helper'

ArchivesSpace::Application.config.after_initialize do
  # only add faceting if configured
  if AppConfig.has_key?(:aspace_reparative_descriptions_faceting) && AppConfig[:aspace_reparative_descriptions_faceting] == true
    Plugins::add_search_base_facets('reparative_descriptions_u_sbool')
  end

  JSONModel(:reparative_description)

end
