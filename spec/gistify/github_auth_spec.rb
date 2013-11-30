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

      context 'given an invalid username or password' do
        it 'returns a helpful error message' do
          VCR.use_cassette('bad-login') do
            expect{GithubAuth.login 'bad_username', 'bad_password'}.to raise_error(InvalidCredentialsError,
              "The Username/Password combination you entered was invalid. Please make sure you didn't misspell anything."
            )
          end
        end
      end
    end
  end
end