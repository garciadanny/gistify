require 'spec_helper'

module Gistify
  describe GithubAuth do
    context 'given a valid username and password' do
      let(:username) { 'mrsquarepants' }
      let(:password) { 'password1' }

      it 'creates an oauth token for the client' do
        VCR.use_cassette('githubauth-login') do
          token = GithubAuth.login username, password

          expect(token).to_not be_nil
          expect(token).to be_a String
        end
      end

      it 'saves the token to ~/.gistify-USERNAME' do
        VCR.use_cassette('githubauth-login') do
          token = GithubAuth.login username, password

          file_path = File.join(Dir.home, "/.gistify-#{username}")
          file = File.open file_path

          expect(file.read).to eq token
        end
      end
    end
  end
end