require 'spec_helper'

module Gistify

  describe GithubGist do

    describe '.list' do

      before do
        VCR.use_cassette('githubauth-login') do
          authenticate_client
        end
      end

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
              'files' => { 'file_one' => {}, 'file_two' => {} },
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
          home_directory = File.join(Dir.home, '/.gistify')
          File.open(home_directory, 'w') { |f| f.write token }

          expect(GithubGist.send :user_token).to eq token
        end
      end
    end
  end
end