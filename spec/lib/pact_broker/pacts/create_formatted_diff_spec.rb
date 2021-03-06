require 'spec_helper'
require 'pact_broker/pacts/create_formatted_diff'
require 'pact_broker/pacts/repository'

module PactBroker
  module Pacts
    describe CreateFormattedDiff do

      describe ".call" do

        let(:pact_content_version_1) do
          hash = load_json_fixture('consumer-provider.json')
          hash['interactions'].first['request']['method'] = 'post'
          hash.to_json
        end

        let(:pact_content_version_2) { load_fixture('consumer-provider.json') }

        subject { CreateFormattedDiff.call(pact_content_version_2, pact_content_version_1) }

        it "returns the formatted diff" do
          expect(subject).to include 'interactions'
          expect(subject).to include 'post'
          expect(subject).to include 'get'
          expect(subject).to include '+'
          expect(subject).to include '-'
        end

      end

    end
  end
end
