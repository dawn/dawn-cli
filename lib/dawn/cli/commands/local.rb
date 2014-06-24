require "dawn/cli/commands/base_commands"

module Dawn
  module CLI
    module Local

      extend Dawn::CLI::BaseCommands

      def self.health_check
        Dawn::API.health_check
      end

    end
  end
end
