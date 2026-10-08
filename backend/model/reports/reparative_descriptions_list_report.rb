class ReparativeDescriptionsListReport < AbstractReport

  register_report

  # [table, label shown in the report]
  RECORD_TYPES = [
    ['resource', 'resource'],
    ['accession', 'accession'],
    ['archival_object', 'archival object'],
    ['digital_object', 'digital object'],
    ['digital_object_component', 'digital object component']
  ].freeze

  def query_string
    selects = RECORD_TYPES.map do |table, label|
      "(SELECT
          reparative_description.reparative_description_date AS date,
          reparative_description.description AS description,
          #{table}.title AS title,
          #{db.literal(label)} AS type,
          enumeration_value.value AS tag_code
        FROM reparative_description
        JOIN #{table} ON #{table}.id = reparative_description.#{table}_id
        LEFT JOIN reparative_description_reason ON reparative_description_reason.reparative_description_id = reparative_description.id
        LEFT JOIN enumeration_value ON enumeration_value.id = reparative_description_reason.content_warning_code_id
        WHERE #{table}.repo_id = #{db.literal(@repo_id)})"
    end

    "#{selects.join(' UNION ALL ')}
      ORDER BY title ASC, date ASC, tag_code ASC"
  end

end
