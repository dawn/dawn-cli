require "dawn/cli/helpers"

module Dawn
  module CLI
    module BaseCommands

      include Dawn::CLI::Helpers

      ###
      # @param [Symbol] sym
      # @param [Array<Objects>] *args
      ###
      def command(sym, *args, &block)
        if Dawn::CLI.no_operation
          say "#{self}.#{sym}(#{args.map(&:inspect).join(", ")})"
        else
          send(sym, *args, &block)
        end
        sym
      end

    end
  end
end
