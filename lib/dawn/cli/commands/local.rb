require "dawn/cli/helpers"

module Dawn
  module CLI
    module Local

      extend Dawn::CLI::Helpers

      def self.health_check
        Dawn::API.health_check
      end

    end
  end
end
