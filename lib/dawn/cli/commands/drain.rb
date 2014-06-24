require "dawn/cli/commands/base_commands"

module Dawn
  module CLI
    module Drain

      extend Dawn::CLI::BaseCommands

      # "List all drains for the current app"
      def self.list
        say format_drains(current_app.drains.all)
      end

      # "Add a new drain to the current app"
      def self.add(url)
        current_app.drains.create(drain: { url: url })
      end

      # "Remove an existing drain from the current app"
      def self.delete(url)
        current_app.drains.delete(url: url)
      end

    end
  end
end
