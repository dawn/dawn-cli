require "dawn/cli/commands/base_commands"

module Dawn
  module CLI
    module Drain
      extend Dawn::CLI::BaseCommands

      ###
      # "List all drains for the current app"
      ###
      def self.list
        say format_drains(current_app.drains.all)
      end

      ###
      # "Add a new drain to the current app"
      # @param [String] url
      ###
      def self.add(url)
        current_app.drains.create(drain: { url: url })
      rescue Excon::Errors::Conflict => ex
        handle_abort_exception("dawn drain add", ex)
      end

      ###
      # "Remove an existing drain from the current app"
      # @param [String] url
      ###
      def self.delete(url)
        current_app.drains.destroy(url: url)
      rescue Excon::Errors::NotFound => ex
        handle_abort_exception("dawn drain delete", ex)
      end
    end
  end
end
