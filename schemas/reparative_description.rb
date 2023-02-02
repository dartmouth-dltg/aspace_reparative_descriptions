{
  :schema => {
    "$schema" => "http://www.archivesspace.org/archivesspace.json",
    "version" => 1,
    "type" => "object",
    "properties" => {
      "reparative_description_date" => {
        "type" => "date",
        "ifmissing" => "error"
      },
      "description" => {
        "type" => "string",
      },
      "reparative_description_reasons" => {
        "type" => "array",
        "items" => {
          "type" => "JSONModel(:reparative_description_reason) object"
        },
      }
    }
  }
}
