require_relative '../lib/reparative_descriptions_helper'

ArchivesSpace::Application.config.after_initialize do
  # only add faceting if configured
  if AppConfig.has_key?(:aspace_reparative_descriptions) && AppConfig[:aspace_reparative_descriptions]['staff_faceting'] == true
    SearchResultData.class_eval do
      self.singleton_class.send(:alias_method, :BASE_FACETS_pre_reparative_descriptions, :BASE_FACETS)
      def self.BASE_FACETS
        self.BASE_FACETS_pre_reparative_descriptions << "reparative_descriptions_u_sbool"
      end
    end
  end

  JSONModel(:reparative_description)

end
