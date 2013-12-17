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
      git_create_dawn_remote(app)
    end
  end
end

command "init" do |c|
  c.syntax = "dawn init"
  c.description = "Setup existing app with a dawn remote"
  c.action do |args, options|
    app = try_create_app(appname)
    git_create_dawn_remote(app)
  end
end

command "rename" do |c|
  c.syntax = "dawn rename <newname>"
  c.action do |args, options|
    app_name = args.first
    app = current_app
    app.update(name: app_name)
  end
end

command "logs" do |c|
  c.syntax = "dawn logs [tail]"
  c.description = "Prints the App's log to STDOUT"
  c.action do |args, options|
    opts = {}
    opts[:tail] = true if args.include?("tail")
    app = current_app
    url = app.logs(opts)
    begin
      streamer = lambda do |chunk, remaining_bytes, total_bytes|
        puts chunk
      end
      Excon.get(url, response_block: streamer, query: { srv: 1 })
    rescue Interrupt
    end
  end
end