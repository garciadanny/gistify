require 'spec_helper'
require 'pry'

module Gistify

  describe GithubGist do

    describe '.list' do

      before { authenticate_client }

      context 'given an authenticated client' do
        it "calls .print_response to print gists to the screen" do
          VCR.use_cassette('github-gist-list') do
            expect(GithubGist).to receive :print_response
            gists = GithubGist.list
          end
        end
      end
    end

    describe '.parse' do
      context 'given a suceessful response' do
        it 'parses the response into a hash with the gist info' do
          response = [
              {'html_url' => 'http://example.com',
               'files' => {'file_one' => {}, 'file_two' => {}},
               'description' => 'very intellectual description'
              }
          ]

          expected_response = [{
                                   'Filename(s)' => ['file_one', 'file_two'],
                                   'Description' => 'very intellectual description',
                                   'URL' => 'http://example.com'
                               }]
          expect(GithubGist.send :parse, response).to eq expected_response
        end
      end
    end

    describe '.user_token' do

      context 'given a ~/.gistify file exists' do
        it 'retrieves the user token from the file' do
          token = 'user_token1234567'
          token_directory = File.join(Dir.home, '/.gistify')
          File.open(token_directory, 'w') { |f| f.write token }

          expect(GithubGist.send :user_token).to eq token
        end
      end
    end

    describe '.file' do
      context 'given an authenticated client' do

        context 'when the file is found' do
          let(:file_name) { 'a.rb' }
          let(:file_contents) { 'abc' }
          let(:file_location) { File.join FileUtils.pwd, file_name }

          before(:each) do
            authenticate_client
            File.open(file_location, 'w') { |f| f.write file_contents }
          end

          after(:all) do
            test_file = File.join(FileUtils.pwd, '/a.rb')
            File.delete(test_file) if File.exists? test_file
          end

          it 'reads the contents of a file' do
            VCR.use_cassette('create_gist') do
              expect(GithubGist).to receive(:read_file_contents).with(file_location).and_return file_contents
              GithubGist.file file_name
            end
          end

          it 'creates a gist' do
            VCR.use_cassette('create_gist') do
              expect(GithubGist.file file_name).to match /https:/
            end
          end
        end

        context 'when the file is not found' do
          it 'raises a FileNotFound error' do
            expect{ GithubGist.file 'doesnt_exist.rb' }.to raise_error(FileNotFound,
              "File not found. Please make sure to `cd` into the file's directory"
            )
          end
        end

      end
    end
  end
end