class ReparativeDescriptionsListReport < AbstractReport

  register_report

  def query_string
  "(
    SELECT
        reparative_description_date AS date,
        reparative_description.description as description,
        resource.title AS title,
        'resource' AS TYPE,
        enumeration_value.value AS tag_code
    FROM
        reparative_description
    LEFT JOIN reparative_description_reason ON reparative_description_reason.reparative_description_id = reparative_description.id
    LEFT JOIN resource ON resource.id = reparative_description.resource_id
    LEFT JOIN enumeration_value ON enumeration_value.id = reparative_description_reason.content_warning_code_id
    WHERE
        reparative_description.resource_id IS NOT NULL
    )
  UNION
      (
        SELECT
            reparative_description_date as date,
            reparative_description.description as description,
            accession.title AS title,
            'accession' AS TYPE,
            enumeration_value.value AS tag_code
        FROM
            reparative_description
        LEFT JOIN reparative_description_reason ON reparative_description_reason.reparative_description_id = reparative_description.id
        LEFT JOIN accession ON accession.id = reparative_description.accession_id
        LEFT JOIN enumeration_value ON enumeration_value.id = reparative_description_reason.content_warning_code_id
        WHERE
            reparative_description.accession_id IS NOT NULL
    )
  UNION
      (
        SELECT
            reparative_description_date AS date,
            reparative_description.description as description,
            archival_object.title AS title,
            'archival object' AS TYPE,
            enumeration_value.value AS tag_code
        FROM
            reparative_description
        LEFT JOIN reparative_description_reason ON reparative_description_reason.reparative_description_id = reparative_description.id
        LEFT JOIN archival_object ON archival_object.id = reparative_description.archival_object_id
        LEFT JOIN enumeration_value ON enumeration_value.id = reparative_description_reason.content_warning_code_id
        WHERE
            reparative_description.archival_object_id IS NOT NULL
    )
  UNION
      (
        SELECT
            reparative_description_date AS date,
            reparative_description.description as description,
            digital_object.title AS title,
            'digital object' AS TYPE,
            enumeration_value.value AS tag_code
        FROM
            reparative_description
        LEFT JOIN reparative_description_reason ON reparative_description_reason.reparative_description_id = reparative_description.id
        LEFT JOIN digital_object ON digital_object.id = reparative_description.digital_object_id
        LEFT JOIN enumeration_value ON enumeration_value.id = reparative_description_reason.content_warning_code_id
        WHERE
            reparative_description.digital_object_id IS NOT NULL
    )
  UNION
      (
        SELECT
            reparative_description_date AS date,
            reparative_description.description as description,
            digital_object_component.title AS title,
            'digital object component' AS TYPE,
            enumeration_value.value AS tag_code
        FROM
            reparative_description
        LEFT JOIN reparative_description_reason ON reparative_description_reason.reparative_description_id = reparative_description.id
        LEFT JOIN digital_object_component ON digital_object_component.id = reparative_description.digital_object_component_id
        LEFT JOIN enumeration_value ON enumeration_value.id = reparative_description_reason.content_warning_code_id
        WHERE
            reparative_description.digital_object_component_id IS NOT NULL
    )
    ORDER BY
        title asc,
        date asc,
        tag_code asc
  "
  end

end
