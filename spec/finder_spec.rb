# frozen_string_literal: true

require_relative '../lib/finder'
require 'fakefs/spec_helpers'

describe Finder do
  subject { described_class.new(args).call }

  let(:args) { '' }
  let(:always_present) { ['.', '..'] }
  let(:local_files) { ['/file.txt'] }
  let(:local_dirs) { [] }
  let(:expected_files) { local_dirs + local_files }

  context 'no args, one file' do
    it "should return file in current directory" do
      FakeFS.with_fresh do
        local_files.each do |file_name|
          FileUtils.touch(file_name)
        end
        expect(subject).to eq(expected_files)
      end
    end
  end

  context 'no args, nested file' do
    let(:local_dirs) { ['/some_dir'] }
    let(:local_files) { ['/some_dir/file.txt'] }

    it "should return file in directory within current directory" do
      FakeFS.with_fresh do
        local_dirs.each do |dir_name|
          Dir.mkdir(dir_name)
        end
        local_files.each do |file_name|
          FileUtils.touch(file_name)
        end
        expect(subject).to eq(expected_files)
      end
    end
  end
end
