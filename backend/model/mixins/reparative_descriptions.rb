module ReparativeDescriptions

  def self.included(base)
    base.one_to_many :reparative_description

    base.def_nested_record(:the_property => :reparative_descriptions,
                           :contains_records_of_type => :reparative_description,
                           :corresponding_to_association  => :reparative_description,
                           :is_array => true)
  end

end
