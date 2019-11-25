# frozen_string_literal: true

require "yaml"
require "oai_index"
require "traject/macros/nokogiri_macros"
extend Traject::Macros::NokogiriMacros

if File.exist? "config/blacklight.yml"
  solr_config = YAML.load_file("config/blacklight.yml")[(ENV["RAILS_ENV"] || "development")]
  solr_url = ERB.new(solr_config["funcake_oai_url"]).result
else
  solr_url = ENV["FUNCAKE_OAI_SOLR_URL"]
end


settings do
  provide "solr.version", "8.0.0"
  provide "solr_writer.max_skipped", -1
  provide "solr.url", solr_url
  provide "solr_writer.commit_on_close", false

  if ENV["SOLR_AUTH_USER"] && ENV["SOLR_AUTH_PASSWORD"]
    provide "solr_writer.basic_auth_user", ENV["SOLR_AUTH_USER"]
    provide "solr_writer.basic_auth_password", ENV["SOLR_AUTH_PASSWORD"]
  end

	provide "nokogiri.namespaces",
					"oai" => "http://www.openarchives.org/OAI/2.0/",
					"dc" => "http://purl.org/dc/elements/1.1/"
          #"dcterms" => "http://purl.org/dc/terms/",
          #"oai_dc" => "http://www.openarchives.org/OAI/2.0/oai_dc/",
          #"edm" => "http://www.europeana.eu/schemas/edm/",
          #"dpla" => "http://dp.la/about/map/",
          #"schema" => "http://schema.org",
          #"oai_qdc" => "http://worldcat.org/xmlschemas/qdc-1.0/",
          #"svcs" => "http://rdfs.org/sioc/services"

  provide "nokogiri.each_record_xpath", "/xslt-output/oai_dc:dc"


end

require "pry"
each_record do |record, context|
  binding.pry

  if record.fields("245").any? { |f| f["a"].to_s.downcase.include? "host bibliographic record for boundwith item barcode" }
    context.skip!("Skipping Boundwith host record")
  end
end

to_field "id", extract_xpath("//dcterms:identifier"), first_only
to_field "payload_ss", &-> (r, acc) { acc << r.to_s }
to_field "timestamp_dtsi", &-> (_, acc) { acc << Time.now }
#to_field("set_ssim", 
