# frozen_string_literal: true

require_relative '../lib/finder'
require 'fakefs/spec_helpers'
require 'pry'

describe Finder do
  subject { described_class.new(args).call }

  let(:args) { {} }
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
    let(:args) { { starting_path: 'some_dir' } }

    it "returns files in starting path" do
      FakeFS.with_fresh do
        setup_files(local_dirs, local_files)
        expect(subject).to eq(['file.txt'])
      end
    end
  end

  context 'matches expression' do
    let(:local_files) { ['matches.txt', 'does_not_match.rb'] }
    let(:args) { { match_pattern: '*.txt' } }

    it "returns files in starting path" do
      FakeFS.with_fresh do
        setup_files(local_dirs, local_files)
        expect(subject).to eq(['/matches.txt'])
      end
    end
  end

  context 'only empty files' do
    let(:file_with_contents) { 'full.txt' }
    let(:local_files) { ['empty.txt', file_with_contents] }
    let(:args) { { only_empty_files: true } }

    it "returns files in starting path" do
      FakeFS.with_fresh do
        setup_files(local_dirs, local_files)
        File.write(file_with_contents, 'data')
        expect(subject).to eq(['/empty.txt'])
      end
    end
  end

  context 'symlinks' do
    let(:normal_filename) { 'normal.txt' }
    let(:symlink_filename) { 'symlink.txt' }
    let(:local_files) { [normal_filename] }
    let(:args) { { follow_symlinks: true } }

    it "returns files in starting path" do
      FakeFS.with_fresh do
        setup_files(local_dirs, local_files)
        FileUtils.ln_s(normal_filename, symlink_filename)
        expect(subject).to eq([normal_filename, symlink_filename])
      end
    end
  end

  # TODO write test with all the current options
end
