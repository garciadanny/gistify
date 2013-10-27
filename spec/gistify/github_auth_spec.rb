require 'spec_helper'

module Gistify
  describe GithubAuth do

    describe '.login' do

      context 'given a valid username and password' do
        let(:username)   { 'mrsquarepants' }
        let(:password)   { 'password1' }

        it 'creates a oauth token for the user' do
          VCR.use_cassette('githubauth_login') do
            token = GithubAuth.login username, password
            expect(token).to_not be_nil
          end
        end

        it 'saves the token to ~/gistify-USERNAME' do
        end
      end
    end
  end
end