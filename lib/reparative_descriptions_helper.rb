require 'aspace_logger'
class AspaceReparativeDescriptionsHelper

  def self.assemble_reparative_description_text(rd, parse = false)
    cws = []
    date = rd['reparative_description_date']
    rd_reasons = rd['reparative_description_reasons']
    rd_reasons.each do |rdr|
      cw_type = rdr['content_warning_code']
      cws << I18n.t("enumerations.content_warning_code.#{cw_type}")
    end
    reasons = cws.join(', ')

    # generate the generic statement if there are no reasons
    if cws.empty?
      rd_reasons_text = I18n.t("reparative_description_reasons_generic", :date => date)
    else 
      if cws.length > 2
        reasons = reasons.reverse.sub(' ,', ' dna ,').reverse
      else
        reasons = reasons.reverse.sub(' ,', ' dna ').reverse
      end
      rd_reasons_text = I18n.t("reparative_description_reasons_template", :reasons => reasons, :date => date)
    end

    unless rd['description'].nil?
      rd_reasons_text += ' ' + rd['description']
    end
    
    rd_reasons_text
  end

  def self.sort_reparative_descriptions(reparative_descriptions)
    rds = reparative_descriptions.sort_by { |rd| rd['reparative_description_date'] }  
    if AppConfig[:aspace_reparative_descriptions_sort] == 'desc'
        rds.reverse!
    end
    rds
  end

end