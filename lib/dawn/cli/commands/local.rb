module Dawn
  module CLI
    module Local

      def health_check
        Dawn::API.health_check
      end

      # "Create a new dawn App (with git; setup)"
      def create(appname=nil)
        app = try_create_app appname
        # since its possible for dawn to create a new app, with a random name
        # setting the appname again based on the real app's name is required
        appname = app.name
        git_add_dawn_remote app
        puts "\tAPP\t#{app.name}"
      end

    end
  end
end
