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
        it "lists the client's gists" do
          VCR.use_cassette('github-gist-list') do
            gists = GithubGist.list

            expect(gists).to be_an Array
          end
        end
      end
    end
  end
end