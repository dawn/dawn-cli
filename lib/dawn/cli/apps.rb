command 'apps:create' do |c|
  c.action do |args, options|
    resp = @api.request(
      method: :post,
      path: '/apps',
      query: { name: args.first }
    )
    #`git remote add dawn git@anzejagodic.com:#{resp[:name]}`
    hsh = JSON.load(resp.body)
    puts "Created app #{hsh["app"]["name"]}"
  end
end

command 'apps:list' do |c|
  c.action do |args, options|
    resp = @api.request(
      method: :get,
      path: '/apps'
    )
    hsh = JSON.load(resp.body)
    if hsh.empty?
      puts " ! Looks like you don't have any apps yet, why not create one using apps:create <name>"
    else
      hsh.each do |app_hash|
        puts app_hash
      end
    end
  end
end

command 'apps:get' do |c|
  c.action do |args, options|
    resp = @api.request(
      method: :get,
      path: "/apps/#{args.first}"
    )
    hsh = JSON.load(resp.body)
    puts hsh
  end
end

command 'apps:update' do |c|
  c.action do |args, options|
    resp = @api.request(
      method: :puts,
      path: "/apps/#{args.first}"
    )
    puts resp
  end
end

command 'apps:delete' do |c|
  c.action do |args, options|
    app_id = args.first
    resp = @api.request(
      method: :delete,
      path: "/apps/#{app_id}"
    )
    case resp.status
    when 404 then puts "App (id=#{app_id}) not found"
    when 500 then puts "App (id=#{app_id}) cannot be deleted"
    when 204 then puts "App (id=#{app_id}) deleted sucessfully"
    end
  end
end