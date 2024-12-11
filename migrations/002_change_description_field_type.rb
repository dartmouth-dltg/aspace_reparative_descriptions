require 'db/migrations/utils'

Sequel.migration do

  up do
    $stderr.puts("Changing Reparative Description description field from MediumBlob to Long Text")

    alter_table(:reparative_description) do
      set_column_type(:description, 'text')
    end

  end

end
