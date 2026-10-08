class AspaceReparativeDescriptionsHelper

  def self.assemble_reparative_description_text(rd)
    date = rd['reparative_description_date']
    reasons = Array(rd['reparative_description_reasons']).map do |rdr|
      cw_type = rdr['content_warning_code']
      I18n.t("enumerations.content_warning_code.#{cw_type}", :default => cw_type.to_s)
    end

    # generate the generic statement if there are no reasons
    text = if reasons.empty?
             I18n.t("reparative_description_reasons_generic", :date => date)
           else
             I18n.t("reparative_description_reasons_template", :reasons => join_reasons(reasons), :date => date)
           end

    rd['description'].nil? ? text : "#{rd['description']} #{text}"
  end

  # "a", "a and b", "a, b, and c"
  def self.join_reasons(reasons)
    return reasons.first if reasons.length < 2
    return reasons.join(' and ') if reasons.length == 2

    "#{reasons[0..-2].join(', ')}, and #{reasons.last}"
  end

  # Always returns an array; sorts only if configured.
  # (AppConfig[] raises on unset keys, hence has_key?)
  def self.sort_reparative_descriptions(reparative_descriptions)
    rds = Array(reparative_descriptions)
    order = AppConfig.has_key?(:aspace_reparative_descriptions_sort) ? AppConfig[:aspace_reparative_descriptions_sort] : nil
    return rds unless ['asc', 'desc'].include?(order)

    rds = rds.sort_by { |rd| rd['reparative_description_date'].to_s }
    order == 'desc' ? rds.reverse : rds
  end

end
