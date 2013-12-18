def print_apps(apps)
  say "ID\t\t\t\tNAME\t\tFORMATION"
  apps.each do |app|
    form = app.formation.map { |k,v| "#{k}: #{v}" }.join(",")
    say "#{app.id}\t#{app.name}\t#{form}"
  end
end

def print_gears(gears)
  say "ID\t\t\t\tNAME\t\tTYPE\t\tNUMBER"
  gears.each do |gear|
    say "#{gear.id}\t#{gear.name}\t\t#{gear.type}\t\t#{gear.number}"
  end
end

def git_create_dawn_remote(app)
  Dawn::Helpers.git("remote add dawn git@anzejagodic.com:#{app.git}")
end

def try_create_app(appname)
  begin
    app = Dawn::App.create(name: appname)
  rescue Excon::Errors::Conflict
    app = Dawn::App.find(name: appname)
    say " warning ! App #{app.name} already exists"
  end
  return app
end

def git_remotes(base_dir=Dir.pwd)
  remotes = {}
  original_dir = Dir.pwd
  Dir.chdir(base_dir) do
    return unless File.exists?(".git")
    Dawn::Helpers.git("remote -v").split("\n").each do |remote|
      name, url, method = remote.split(/\s+/)
      if url =~ /^git@#{Dawn.git_host}:([\w\d-]+)\.git$/
        remotes[name] = $1
      end
    end
  end
  remotes.empty? ? nil : remotes
end

def extract_app_remote_from_git_config
  remote = Dawn::Helpers.git("config dawn.remote")
  remote.empty? ? nil : remote
end

def extract_app_in_dir(dir, options={})
  return unless remotes = git_remotes(dir)
  if remote = options[:remote]
    remotes[remote]
  elsif remote = extract_app_remote_from_git_config
    remotes[remote]
  else
    apps = remotes.values.uniq
    if apps.size == 1
      apps.first
    else
      raise "Multiple apps in folder and no app specified.\nSpecify app with --app APP."
    end
  end
end

def current_app_name(options={})
  @current_app ||= if options.key?(:app)
    options[:app]
  elsif ENV.key?("DAWN_APP")
    ENV["DAWN_APP"]
  elsif app_from_dir = extract_app_in_dir(Dir.pwd, options)
    app_from_dir
  else
    raise "App could not be located!"
  end
end

def current_app
  Dawn::App.find(name: current_app_name)
end

require 'dawn/cli/commands/app'   # App management namespace
require 'dawn/cli/commands/env'   # App ENV management namespace
require 'dawn/cli/commands/key'   # Key management namespace
require 'dawn/cli/commands/local' # Various functions
require 'dawn/cli/commands/login' # Netrc setup and login command