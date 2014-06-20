module Dawn
  module CLI
    module Drain

      extend self

      # "List all drains for the current app"
      def list
        puts format_drains(current_app.drains.all)
      end

      # "Add a new drain to the current app"
      def add(url)
        current_app.drains.create(drain: { url: url })
      end

      # "Remove an existing drain from the current app"
      def delete(url)
        current_app.drains.delete(url: url)
      end

    end
  end
end
