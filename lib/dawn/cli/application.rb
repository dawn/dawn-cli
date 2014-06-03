require 'dawn/cli/commands'    # CLI Commands

module Dawn
  module CLI
    class Application

      include Commander::Methods

      def run
        # :name is optional, otherwise uses the basename of this executable
        program :name, 'Dawn CLI'
        program :version, Dawn::CLI::VERSION + "α"
        program :description, 'CLI client for Dawn'

        default_command 'help'

        app_commands
        domain_commands
        drain_commands
        env_commands
        key_commands
        local_commands
        login_commands
      end

    end
  end
end