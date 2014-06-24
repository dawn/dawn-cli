require "dawn/cli/commands/base_commands"

module Dawn
  module CLI
    module Env

      extend Dawn::CLI::BaseCommands

      ###
      # "Displays all the current app's ENV variables"
      ###
      def self.list
        current_app.env.each do |k, v|
          say "#{k}=#{v}"
        end
      end

      ###
      # "Get an ENV var"
      ###
      def self.get(*keys)
        app = current_app
        env = app.env
        keys.each do |k|
          say "#{k}=#{env[k]}"
        end
      end

      ###
      # "Set multiple ENV variables"
      # @param [Hash<String, String>] env
      ###
      def self.set(env)
        app = current_app
        app.env.update(app.env.merge(env)) # this is a Hash method
        app.env.save                       # this is an API method
      end

      ###
      # "Deletes an ENV var"
      # @param [Array<String>] *keys
      ###
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
