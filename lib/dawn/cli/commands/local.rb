require "dawn/cli/commands/base_commands"

module Dawn
  module CLI
    module Local

      extend Dawn::CLI::BaseCommands

      ###
      # "verify if server is running"
      ###
      def self.health_check
        Dawn::API.health_check
        say "All is well"
      end

      ###
      # "print current username to console"
      ###
      def self.whoami
        account = Dawn::Account.current
        say account.username
      end

    end
  end
end
