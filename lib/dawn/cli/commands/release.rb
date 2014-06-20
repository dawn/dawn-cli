require "dawn/cli/helpers"

module Dawn
  module CLI
    module Release

      extend Dawn::CLI::Helpers

      # "List all releases for the current app"
      def self.list
        puts format_releases(current_app.releases.all)
      end

      # "Add a new release to the current app"
      def self.add
        current_app.releases.create(release:{})
      end

    end
  end
end
