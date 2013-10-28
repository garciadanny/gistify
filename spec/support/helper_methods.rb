module Gistify
  module HelperMethods

    def authenticate_client
      GithubAuth.login 'mrsquarepants', 'password1'
    end
  end
end