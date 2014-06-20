require "dawn/cli/helpers"

module Dawn
  module CLI
    module Env

      extend Dawn::CLI::Helpers

      # displays all the current app's ENV variables
      def self.list
        current_app.env.each do |k, v|
          puts "#{k}=#{v}"
        end
      end

      # "Get an ENV var"
      def self.get(*keys)
        app = current_app
        env = app.env
        keys.each do |k|
          puts "#{k}=#{env[k]}"
        end
      end

      # "Set multiple ENV variables"
      def self.set(hash)
        app = current_app
        app.env.update(app.env.merge(hash)) # this is a Hash method
        app.env.save                        # this is a API method
      end

      # "Deletes an ENV var"
      def self.unset(*keys)
        app = current_app
        keys.each do |k|
          app.env.delete(k)
        end
        app.env.save
      end

    end
  end
end
