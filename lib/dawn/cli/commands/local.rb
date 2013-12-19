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
  c.syntax = "dawn logs [-f]"
  c.description = "Prints the App's log to STDOUT"
  c.option "-f", "should the logs be followed?"
  c.action do |args, options|
    opts = {}
    opts[:tail] = true if options[:f]
    filters = args # TODO
    app = current_app
    url = app.logs(opts)
    uri  = URI.parse(url)
    begin
      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = 60 * 60 * 24
      begin
        http.start do
          http.request_get(uri.path + (uri.query ? "?" + uri.query : "")) do |request|
            request.read_body do |chunk|
              #yield chunk
              say chunk.to_s
            end
          end
        end
      rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT, SocketError
        raise "Could not connect to logging service"
      rescue Timeout::Error, EOFError
        raise "\nRequest timed out"
      end
    rescue Interrupt
    end
  end
end

command "ps" do |c|
  c.syntax = "dawn ps [<gear_name>]"
  c.description = "Lists all currently running gears"
  c.action do |args, options|
    app = current_app
    gears = app.gears.sort_by(&:number)
    if args.empty?
      ## Print all Gears
      gears_by_type = gears.each_with_object({}) do |gear, hsh|
        (hsh[gear.type] ||= []) << gear
      end
      gears_by_type.keys.sort.each do |key|
        grs = gears_by_type[key]
        say "=== #{key}:"
        print_gears(grs)
      end
    else
      ## Print a specific gear
      query = args.first
      gear = gears.find { |gear| gear.name == query }
      if gear
        print_gears([gear])
      else
        say "Gear #{query} was not found."
      end
    end
  end
end

command "restart" do |c|
  c.syntax = "dawn restart"
  c.description = "restart the app"
  c.action do |args, options|
    app = current_app
    app.restart
    say "App #{app.name} has been restarted"
  end
end