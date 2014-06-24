require "dawn/cli/commands/base_commands"

module Dawn
  module CLI
    module Release

      extend Dawn::CLI::BaseCommands

      ###
      # "List all releases for the current app"
      ###
      def self.list
        say format_releases(current_app.releases.all)
      end

      ###
      # "Add a new release to the current app"
      ###
      def self.add
        current_app.releases.create(release:{})
      end

    end
  end
end
