module ReparativeDescriptionReasons

  def self.included(base)
    base.one_to_many :reparative_description_reason

    base.def_nested_record(:the_property => :reparative_description_reasons,
                            :contains_records_of_type => :reparative_description_reason,
                            :corresponding_to_association  => :reparative_description_reason)
  end
  
end
  