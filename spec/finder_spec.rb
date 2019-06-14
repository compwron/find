# frozen_string_literal: true

require_relative '../lib/finder'
require 'fakefs/spec_helpers'

describe Finder do
  subject { described_class.new(args).call }

  let(:args) { [] }
  let(:local_files) { ['/file.txt'] }
  let(:local_dirs) { [] }
  let(:expected_files) { local_dirs + local_files }

  def setup_files(local_dirs, local_files)
    local_dirs.each do |dir_name|
      Dir.mkdir(dir_name)
    end
    local_files.each do |file_name|
      FileUtils.touch(file_name)
    end
  end

  context 'no args, one file' do
    it "returns file in current directory" do
      FakeFS.with_fresh do
        setup_files(local_dirs, local_files)
        expect(subject).to eq(expected_files)
      end
    end
  end

  context 'no args, nested file' do
    let(:local_dirs) { ['/some_dir'] }
    let(:local_files) { ['/some_dir/file.txt'] }

    it "returns file in directory within current directory" do
      FakeFS.with_fresh do
        setup_files(local_dirs, local_files)
        expect(subject).to eq(expected_files)
      end
    end
  end

  context 'starting path arg' do
    let(:local_dirs) { ['/some_dir'] }
    let(:local_files) { ['/some_dir/file.txt', 'not_in_dir.txt'] }
    let(:args) { ['options', 'some_dir'] }

    it "returns files in starting path" do
      FakeFS.with_fresh do
        setup_files(local_dirs, local_files)
        expect(subject).to eq(['file.txt'])
      end
    end
  end
end
