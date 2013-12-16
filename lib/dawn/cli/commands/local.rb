def try_create_app(appname)
  begin
    app = Dawn::App.create(name: appname)
  rescue Excon::Errors::Conflict
    app = Dawn::App.find(name: appname)
    say " warning ! App #{app.name} already exists"
  end
  return app
end

def setup_dawn_remote(app)
  `git remote add dawn git@anzejagodic.com:#{app.name}`
end

command "create" do |c|
  c.syntax = "dawn create <appname>"
  c.description = "Create a new Dawn App with git setup"
  c.action do |args, options|
    appname = args.first

    if Dir.exists?(appname)
      say " warning ! Directory #{appname} already exists"
    else
      Dir.mkdir(appname)
    end
    Dir.chdir(appname) do
      app = try_create_app(appname)
      `git init`
      setup_dawn_remote(app)
    end
  end
end

command "init" do |c|
  c.syntax = "dawn init"
  c.description = "Setup existing app with a dawn remote"
  c.action do |args, options|
    app = try_create_app(appname)
    setup_dawn_remote(app)
  end
end

command "logs" do |c|
  c.syntax = "dawn logs"
  c.description = ""
  c.action do |args, options|
    app
  end
end