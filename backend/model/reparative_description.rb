class ReparativeDescription < Sequel::Model(:reparative_description)
  include ASModel
  
  corresponds_to JSONModel(:reparative_description)

  set_model_scope :global

  include ReparativeDescriptionReasons
  
end
