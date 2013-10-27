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
        end
      end

      it 'saves the token to ~/.gistify-USERNAME' do
      end
    end
  end
end