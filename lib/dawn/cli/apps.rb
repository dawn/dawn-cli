def print_apps(apps)
  puts "ID\t\t\t\tNAME\t\tFORMATION"
  apps.each do |app|
    form = app.formation.map { |k,v| "#{k}: #{v}" }.join(",")
    puts "#{app.id}\t#{app.name}\t#{form}"
  end
end

command 'apps:create' do |c|
  c.action do |args, options|
    appname = args.first
    app = Dawn::App.create(name: appname)
    #app.init_remote # #`git remote add dawn git@anzejagodic.com:#{resp[:name]}`
    puts "New App\n#{app.id}\t#{app.name}"
  end
end

command 'apps:list' do |c|
  c.action do |args, options|
    apps = Dawn::App.all
    print_apps(apps)
  end
end

command 'apps:get' do |c|
  c.action do |args, options|
    app_id = args.first
    app = Dawn::App.find(id: app_id)
    print_apps([app])
  end
end

command 'apps:update' do |c|
  c.action do |args, options|
    app_id = args.first
    app = Dawn::App.find(id: app_id)
    ## TODO ##
    update_options = {}
    app.update(update_options)
  end
end

command 'apps:delete' do |c|
  c.action do |args, options|
    app_id = args.first
    Dawn::App.destroy(id: app_id)
  end
end