# frozen_string_literal: true

require_relative '../lib/finder'
require 'fakefs/spec_helpers'

describe Finder do
  subject { described_class.new(args).call }

  let(:args) { '' }
  let(:always_present) { ['.', '..'] }
  let(:local_files) { ['file.txt'] }
  let(:expected_files) { always_present + local_files }

  context 'no args' do
    it "should return files in current directory" do
      FakeFS do
        local_files.each do |file_name|
          FileUtils.touch(file_name)
        end
        expect(subject).to eq(expected_files)
      end
    end
  end
end
