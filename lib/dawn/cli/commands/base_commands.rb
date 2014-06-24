require "dawn/cli/helpers"

module Dawn
  module CLI
    module BaseCommands

      include Dawn::CLI::Helpers

      def command(sym, *args, &block)
        if Dawn::CLI.no_operation
          say "#{self}.#{sym}(#{args.join(", ")})"
        else
          send(sym, *args, &block)
        end
      end

    end
  end
end
