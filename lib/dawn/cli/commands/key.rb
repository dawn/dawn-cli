require "dawn/cli/commands/base_commands"

module Dawn
  module CLI
    module Key
      extend Dawn::CLI::BaseCommands

      ###
      # "Lists all your Keys currently on dawn"
      ###
      def self.list
        say format_keys(Dawn::Key.all)
      end

      ###
      # "Adds this machine's sshkey to Dawn"
      ###
      def self.add
        filename = File.join(Dir.home, ".ssh/id_rsa.pub")
        pubkey = File.read filename
        key    = Dawn::Key.create(key: pubkey)
      rescue Excon::Errors::UnprocessableEntity => ex
        handle_abort_exception("dawn key add", ex)
      end

      ###
      # "Retrieve a Key by ID"
      # @param [String] id
      ###
      def self.get(id)
        say Dawn::Key.find(id: id).key
      rescue Excon::Errors::NotFound => ex
        handle_abort_exception("dawn key get", ex)
      end

      ###
      # "Delete a Key by ID"
      # @param [String] id
      ###
      def self.delete(id)
        Dawn::Key.destroy(id: id)
      rescue Excon::Errors::NotFound => ex
        handle_abort_exception("dawn key delete", ex)
      end
    end
  end
end
