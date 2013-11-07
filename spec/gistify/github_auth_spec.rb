require 'spec_helper'

module Gistify

  describe GithubAuth do

    describe '.login' do

      context 'given a valid username and password' do
        it 'creates an oauth token for the client' do
          VCR.use_cassette('githubauth-login') do
            token = authenticate_client

            expect(token).to_not be_empty
            expect(token).to be_a String
          end
        end

        it 'saves the token to ~/.gistify' do
          VCR.use_cassette('githubauth-login') do
            token = authenticate_client

            file_path = File.join(Dir.home, '/.gistify')
            file = File.open file_path

            expect(file.read).to eq token
          end
        end
      end
    end
  end
end