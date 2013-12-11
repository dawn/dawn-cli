def print_apps(apps)
  puts "ID\t\t\t\tNAME\t\tFORMATION"
  apps.each do |app|
    form = app.formation.map { |k,v| "#{k}: #{v}" }.join(",")
    puts "#{app.id}\t#{app.name}\t#{form}"
  end
end

command 'app:create' do |c|
  c.action do |args, options|
    appname = args.first
    app = Dawn::App.create(name: appname)
    #app.init_remote # #`git remote add dawn git@anzejagodic.com:#{resp[:name]}`
    puts "New App\n#{app.id}\t#{app.name}"
  end
end

command 'app:list' do |c|
  c.action do |args, options|
    apps = Dawn::App.all
    print_apps(apps)
  end
end

command 'app:get' do |c|
  c.action do |args, options|
    app_id = args.first
    app = Dawn::App.find(id: app_id)
    print_apps([app])
  end
end

command 'app:update' do |c|
  c.action do |args, options|
    app_id = args.first
    app = Dawn::App.find(id: app_id)
    ## TODO ##
    update_options = {}
    app.update(update_options)
  end
end

command 'app:scale' do |c|
  c.action do |args, options|
    app_id = args.first
    app = Dawn::App.find(id: app_id)
    formation = {}
    args[1, args.size-1].each do |s|
      mtch_data = s.match(/(?<type>web|worker)(?<op>[+-=])(?<value>\d+)/)
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

command 'app:delete' do |c|
  c.action do |args, options|
    app_id = args.first
    Dawn::App.destroy(id: app_id)
  end
end