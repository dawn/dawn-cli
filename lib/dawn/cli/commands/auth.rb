require "dawn/cli/helpers"

module Dawn
  module CLI
    module Auth

      extend Dawn::CLI::Helpers

      # "save login details to .netrc"
      # usn = ask "Username: "
      # psw = password "Password: "
      def self.login(username, password)
        Dawn.authenticate(username: username, password: password)
        say " ! login details have been saved to your .netrc"
      end

    end
  end
end
