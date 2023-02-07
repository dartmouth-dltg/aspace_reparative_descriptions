class ReparativeDescriptionReason < Sequel::Model(:reparative_description_reason)
  
  include ASModel

  corresponds_to JSONModel(:reparative_description_reason)

  set_model_scope :global
  
end
  