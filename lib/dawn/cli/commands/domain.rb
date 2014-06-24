require "dawn/cli/commands/base_commands"

module Dawn
  module CLI
    module Domain
      extend Dawn::CLI::BaseCommands

      ###
      # "List all domains for the current app"
      ###
      def self.list
        say format_domains(current_app.domains.all)
      end

      ###
      # "Add a new domain to the current app"
      # @param [String] url
      ###
      def self.add(url)
        current_app.domains.create(domain: { url: url })
      rescue Excon::Errors::Conflict => ex
        handle_abort_exception("dawn domain add", ex)
      end

      ###
      # "Remove an existing domain from the current app"
      # @param [String] url
      ###
      def self.delete(url)
        current_app.domains.destroy(url: url)
      rescue Excon::Errors::NotFound => ex
        handle_abort_exception("dawn domain delete", ex)
      end
    end
  end
end
