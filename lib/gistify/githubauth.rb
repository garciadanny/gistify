require 'httparty'

module Gistify
  class GithubAuth
    include HTTParty
    headers 'User-Agent' => 'garciadanny'

    def self.login username, password
      post_body = {scopes: ['gist']}
      response = post AUTHORIZATIONS_URL, {
          body: post_body.to_json,
          basic_auth: {username: username, password: password}
      }
      token = response.parsed_response['token']
      unless response['message'] == 'Bad credentials'
        save_token token
      else
        invalid_credentials
      end
    end

    private
    def self.save_token user_token
      File.open TOKEN_LOCATION, 'w', 0600 do |f|
        f.write user_token
      end
      user_token
    end

    def self.invalid_credentials
      raise InvalidCredentialsError,
            "The Username/Password combination you entered was invalid. Please make sure you didn't misspell anything."
    end
  end
  class InvalidCredentialsError < StandardError;
  end
end
