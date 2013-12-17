command "app:list" do |c|
  c.syntax = "dawn app:list"
  c.action do |args, options|
    apps = Dawn::App.all
    print_apps(apps)
  end
end

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
  c.syntax = "dawn app:delete"
  c.action do |args, options|
    app = current_app
    app_name = app.name
    app.destroy
    say "#{app_name} has been removed"
  end
end