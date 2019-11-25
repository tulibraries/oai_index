# frozen_string_literal: true

RSpec.describe OaiIndex do
  it "has a version number" do
    expect(OaiIndex::VERSION).not_to be nil
  end

  describe "ingest" do
    before(:example) do
      @indexer = instance_double("Traject::Indexer::MarcIndexer")
      @io = instance_double(IO)

      allow(Traject::Indexer::MarcIndexer).to receive(:new).and_return(@indexer)
      allow(@indexer).to receive_messages(load_config_file: "", process: "")
      allow(@io).to receive_messages(read: "")
      allow(OaiIndex::CLI).to receive_messages(open: @io)
    end

    after(:example) do
      OaiIndex::CLI.ingest
    end

    it "loads indexer" do
      expect(@indexer).to receive(:load_config_file)
      expect(@indexer).to receive(:process)
    end

    context "commit is not set" do
      it "passes solr_writer.commit_on_close: false by default" do
        expect(Traject::Indexer::MarcIndexer).to receive(:new).with("solr_writer.commit_on_close": false)
      end
    end


    context "commit is true" do
      it "passes solr_writer.commit_on_close: true" do
        expect(Traject::Indexer::MarcIndexer).to receive(:new).with("solr_writer.commit_on_close": true)
        OaiIndex::CLI.ingest(commit: true)
      end
    end
  end
end
