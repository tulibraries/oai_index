# frozen_string_literal: true

require "oai_index/version"
require "traject"

module OaiIndex
  module CLI
    def self.ingest(commit: false, delete: false)
      
      indexer = Traject::Indexer::MarcIndexer.new("solr_writer.commit_on_close": commit)
      indexer.load_config_file("#{File.dirname(__FILE__)}/oai_index/indexer_config.rb")
      indexer.writer.delete(query: "*:*") if delete

      indexer.process(StringIO.new(open(ARGV[0]).read))
    end
  end
end
