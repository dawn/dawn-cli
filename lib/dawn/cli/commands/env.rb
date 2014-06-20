module Dawn
  module CLI
    module Env

      # displays all the current app's ENV variables
      def list
        current_app.env.each do |k, v|
          puts "#{k}=#{v}"
        end
      end

      # "Get an ENV var"
      def get(*keys)
        app = current_app
        env = app.env
        keys.each do |k|
          puts "#{k}=#{env[k]}"
        end
      end

      # "Set multiple ENV variables"
      def set(hash)
        app = current_app
        app.env.update(app.env.merge(hash)) # this is a Hash method
        app.env.save                        # this is a API method
      end

      # "Deletes an ENV var"
      def unset(*keys)
        app = current_app
        keys.each do |k|
          app.env.delete(k)
        end
        app.env.save
      end

    end
  end
end
