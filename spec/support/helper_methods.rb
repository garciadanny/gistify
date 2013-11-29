module Gistify
  module HelperMethods

    def authenticate_client
      VCR.use_cassette('githubauth-login') do
        GithubAuth.login ENV['GITHUB_USERNAME'], ENV['GITHUB_PASSWORD']
      end
    end
  end
end