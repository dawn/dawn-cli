module Dawn
module CLI
class Application
def local_commands

#command "ping" do |c|
#  c.syntax "dawn ping"
#  c.description = "Pings the dawn server to determine if its working correctly"
#  c.action do |args, options|
#  end
#end

command "new" do |c|
  c.syntax = "dawn new [<app_name>]"
  c.description = "Create a new dawn App (with git; setup)"

  c.action do |args, options|
    appname = args.first
    app = try_create_app appname
    appname = app.name

    if Dir.exists? appname
      say " warning ! Directory #{appname} already exists"
    else
      FileUtils.mkdir_p appname
      say "\tCREATE\t#{appname}"
    end

    Dir.chdir appname do
      `git init`
      git_add_dawn_remote app
    end
    say "\tAPP\t#{appname}"
  end
end
alias_command "create", "new"

command "init" do |c|
  c.syntax = "dawn init [<app_name>]"
  c.description = "Setup an existing App with a dawn remote, if no <app_name> is given, the App directory's name will be used"

  c.option "--name NAME", String, "name your App"
  c.option "--random", "gives you App an awesome name"

  c.action do |args, options|
    appname = args.first || options.name || File.basename(Dir.getwd)
    appname = nil if options.random
    app = try_create_app appname
    git_add_dawn_remote app
    say "\tAPP\t#{app.name}"
  end
end

end
end
end
end