command "app:list" do |c|
  c.syntax = "dawn app:list"
  c.action do |args, options|
    apps = Dawn::App.all
    print_apps(apps)
  end
end
alias_command "ls", "app:list"

command "app:scale" do |c|
  c.syntax = "dawn app:scale <gear_modifier>"
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
    app.scale(formation: formation)
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
    git_remove_dawn_remote(app)
    say "#{app_name} has been removed"
  end
end