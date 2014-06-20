module Dawn
  module CLI
    module Domain

      extend self

      # "List all domains for the current app"
      def list
        puts format_domains(current_app.domains.all)
      end

      # "Add a new domain to the current app"
      def add(url)
        current_app.domains.create(domain: { url: url })
      end

      # "Remove an existing domain from the current app"
      def delete(url)
        current_app.domains.delete(url: url)
      end

    end
  end
end
