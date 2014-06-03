command "create" do |c|
  c.syntax = "dawn create <app_name>"
  c.description = "Create a new dawn App (with git; setup)"

  c.action do |args, options|
    appname = args.first

    if Dir.exists? appname
      say " warning ! Directory #{appname} already exists"
    else
      Dir.mkdir appname
    end

    Dir.chdir appname do
      app = try_create_app appname
      `git init`
      git_add_dawn_remote app
    end
  end
end

command "init" do |c|
  c.syntax = "dawn init [<app_name>]"
  c.description = "Setup an existing App with a dawn remote, if no <app_name> is given, the App directory's name will be used"

  c.option "--name NAME", String, "name your App"
  c.option "--random", "gives you App an awesome name"

  c.action do |args, options|
    appname = args.first || options.name || File.basename(Dir.getwd)
    appname = nil if !options.random
    app = try_create_app(appname)
    git_add_dawn_remote(app)
  end
end

end
end
end
end