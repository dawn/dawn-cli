def try_create_app(appname=nil)
  abort "dawn remote already exists, please remove it (dawn app:delete)" if git_dawn_remote?
  begin
    app = Dawn::App.create(name: appname)
  rescue Excon::Errors::Conflict
    app = Dawn::App.find(name: appname)
    say " warning ! App (#{app.name}) already exists"
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

def git_dawn_remote?
  !!(git_remotes && git_remotes["dawn"])
end

def git_remove_dawn_remote(app)
  Dawn::Helpers.git("remote remove dawn") # remove old dawn remote
end

def git_add_dawn_remote(app)
  abort "dawn remote already exists, please `dawn app:delete` first" if git_dawn_remote?
  Dawn::Helpers.git("remote add dawn git@#{Dawn.git_host}:#{app.git}")
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
      abort "Multiple apps in folder and no app specified.\nSpecify app with --app APP."
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
    abort "App could not be located!"
  end
end

def current_app
  app = Dawn::App.find(name: current_app_name)
  abort "App (#{current_app_name}) was not found on the dawn server!" unless app
  app
end