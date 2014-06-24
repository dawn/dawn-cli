require "dawn/cli/commands/base_commands"

module Dawn
  module CLI
    module Auth

      extend Dawn::CLI::BaseCommands

      ###
      # "save login details to .netrc"
      # @param [String] username
      # @param [String] password
      ###
      def self.login(username, password)
        Dawn.authenticate(username: username, password: password)
        say "\tLOGIN details have been saved to your ~/.netrc"
      rescue Excon::Errors::BadRequest
        abort "dawn login: Login has failed, check your username and password"
      end

    end
  end
end
