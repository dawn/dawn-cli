module Dawn
module CLI
class Application
def app_commands

command "app:ls" do |c|
  c.syntax = "dawn app:ls"
  c.description = "Displays a list of all the apps you have deployed to dawn"

  c.action do |args, options|
    apps = Dawn::App.all
    say format_apps(apps)
  end
end
alias_command "ls", "app:ls"

command "app:scale" do |c|
  c.syntax = "dawn app:scale <gear_modifier>"
  c.description = "Modify the gears of the current app"

  c.action do |args, options|
    app = current_app
    formation = {}

    args.each do |s|
      mtch_data = s.match(/(?<type>\S+)(?<op>[+-=])(?<value>\d+)/)
      next unless mtch_data

      type = mtch_data[:type]
      value = mtch_data[:value].to_i
      old_formation = (app.formation[type] || 0).to_i

      formation[type] = case mtch_data[:op]
                        when "+" then old_formation + value
                        when "-" then old_formation - value
                        when "=" then value
                        end
    end
    app.scale formation: formation
  end
end

command "app:delete" do |c|
  c.syntax = "dawn app:delete [<app_id>]"
  c.description = "Delete App app_id, if no app_id is provided, the current app is deleted instead"

  c.option "--name APPNAME", String, "specify an app by name to remove"

  c.action do |args, options|
    if app_id = args.first
      app = Dawn::App.find(id: app_id)
    elsif app_name = options.name
      app = Dawn::App.find(name: app_name)
    else
      app = current_app
    end

    app_name = app.name
    app.destroy

    git_remove_dawn_remote app
  end
end

command "app:rename" do |c|
  c.syntax = "dawn rename <new_name>"
  c.description = "Rename the current App to <new_name>"

  c.action do |args, options|
    app_name = args.first
    app = current_app
    app.update name: app_name
  end
end
alias_command "rename", "app:rename"

command "app:logs" do |c|
  c.syntax = "dawn logs [-f]"
  c.description = "Prints the App's log to STDOUT"

  c.option "-f", "should the logs be followed?"

  c.action do |args, options|
    filter_regex = %r{\A(?<timestamp>\S+)\s(?<token>\S+)\[(?<proc_id>\S+)\]\:(?<message>.*)}
    timestamp_regex = %r{(?<year>\d+)-(?<month>\d+)-(?<day>\d+)T(?<hour>\d+)\:(?<minute>\d+)\:(?<second>\d+)\.(?<other>.*)}

    opts = {}
    opts[:tail] = options.f
    filters = args
    app = current_app
    url = app.logs(opts)
    uri  = URI.parse(url)

    begin
      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = 60 * 60 * 24
      begin
        http.start do
          link_url = uri.path + ("?srv=1")
          #say uri.host + ":" + uri.port.to_s + link_url
          http.request_get(link_url) do |request|
            request.read_body do |chunk|
              if filters.size > 0
                chunk.each_line do |line|
                  if mtch_data = line.chomp.match(filter_regex)
                    say mtch_data[0] if filters.include?(mtch_data[:proc_id])
                  end
                end
              else
                say chunk.to_s
              end
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
alias_command "logs", "app:logs"

command "app:gears" do |c|
  c.syntax = "dawn ps [<gear_name>]"
  c.description = "Lists all currently running Gears"

  c.action do |args, options|
    app = current_app
    gears = app.gears.all.sort_by(&:number)

    if args.empty?
      ## Print all Gears
      gears_by_type = gears.each_with_object({}) do |gear, hsh|
        (hsh[gear.type] ||= []) << gear
      end
      gears_by_type.keys.sort.each do |key|
        grs = gears_by_type[key]
        say "=== #{key}:"
        say format_gears grs
      end
    else
      ## Print a specific gear
      query = args.first
      gear = gears.find { |gear| gear.name == query }

      if gear
        say format_gears([gear])
      else
        say "Gear #{query} was not found."
      end
    end
  end
end
alias_command "ps", "app:gears"

command "app:restart" do |c|
  c.syntax = "dawn restart"
  c.description = "Restart the current App"

  c.action do |args, options|
    app = current_app
    app.restart
    say "App #{app.name} has been restarted"
  end
end
alias_command "restart", "app:restart"

end
end
end
end