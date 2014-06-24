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

      def handle_abort_exception(basename, ex)
        error_obj = JSON.load(ex.response.body) rescue nil
        if error_obj
          abort "#{basename}: (#{error_obj["id"]}) #{error_obj["message"]} #{error_obj["error"]}"
        else
          abort "#{basename}: has failed for some unknown reason"
        end
      end
    end
  end
end
