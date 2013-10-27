require 'httparty'

module Gistify
  class GithubAuth
    include HTTParty
    headers 'User-Agent' => 'garciadanny'

    AUTHORIZATIONS_URL = 'https://api.github.com/authorizations'

    def self.login username, password
      post_body = { scopes: ['gist'] }
      response = post AUTHORIZATIONS_URL, {
        body: post_body.to_json,
        basic_auth: { username: username, password: password }
      }
      save_token response.parsed_response['token']
    end

  private
    def self.save_token user_token
      File.open home_directory, 'w', 0600 do |f|
        f.write user_token
      end
      user_token
    end

    def self.home_directory
      File.expand_path '~/.gistify'
    end
  end
end
