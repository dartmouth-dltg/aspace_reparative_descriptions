require 'db/migrations/utils'

Sequel.migration do

  up do
    $stderr.puts("Adding Reparative Description tables")

    create_table(:reparative_description) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false

      Integer :accession_id
      Integer :resource_id
      Integer :archival_object_id
      Integer :digital_object_id
      Integer :digital_object_component_id

      Date :reparative_description_date
      MediumBlobField :description

      apply_mtime_columns
    end

    create_table(:reparative_description_reason) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false

      Integer :reparative_description_id

      DynamicEnum :content_warning_code_id

      apply_mtime_columns
    end

    alter_table(:reparative_description_reason) do
      add_foreign_key([:reparative_description_id], :reparative_description, :key => :id)
    end

    alter_table(:reparative_description) do
      add_foreign_key([:accession_id], :accession, :key => :id)
      add_foreign_key([:resource_id], :resource, :key => :id)
      add_foreign_key([:archival_object_id], :archival_object, :key => :id)
      add_foreign_key([:digital_object_id], :digital_object, :key => :id)
      add_foreign_key([:digital_object_component_id], :digital_object_component, :key => :id)
    end

  end

end