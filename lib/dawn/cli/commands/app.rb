command "app:create" do |c|
  c.syntax = "dawn app:create <app_name>"
  c.action do |args, options|
    app_name = args.first
    app = Dawn::App.create(name: app_name)
    #app.init_remote # #`git remote add dawn git@anzejagodic.com:#{resp[:name]}`
    puts "New App\n#{app.id}\t#{app.name}"
  end
end

command "app:list" do |c|
  c.syntax = "dawn app:list"
  c.action do |args, options|
    apps = Dawn::App.all
    print_apps(apps)
  end
end

command "app:get" do |c|
  c.syntax = "dawn app:create <app_id or app_name (with --name)>"
  c.option "--name NAME", String, "name of the app"
  c.action do |args, options|
    app = find_app_by_id_or_name(args, options)
    print_apps([app])
  end
end

command "app:update" do |c|
  c.syntax = "dawn app:update <app_id or app_name (with --name)>"
  c.option "--name NAME", String, "name of the app"
  c.action do |args, options|
    app = find_app_by_id_or_name(args, options)
    ## TODO ##
    update_options = {}
    app.update(update_options)
  end
end

command "app:scale" do |c|
  c.syntax = "dawn app:scale <app_id or app_name (with --name)>"
  c.option "--name NAME", String, "name of the app"
  c.action do |args, options|
    app = find_app_by_id_or_name(args, options)
    gears = options.key?(:name) ? args : args[1, args.size-1]
    formation = {}
    gears.each do |s|
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
  c.syntax = "dawn app:delete <app_id or app_name (with --name)>"
  c.option "--name NAME", String, "name of the app"
  c.action do |args, options|
    app = find_app_by_id_or_name(args, options)
    app.destroy if app
  end
end