command 'keys:add' do |c|
  c.action do |args, options|
    file = "#{Dir.home}/.ssh/id_rsa.pub"
    pubkey = File.read(file)
    fingerprint = `ssh-keygen -lf #{file}`
    resp = @api.request(
      method: :post,
      path: '/account/keys',
      query: { key: pubkey, fingerprint: fingerprint }
    )
    puts resp.body
  end
end

command 'keys:list' do |c|
  c.action do |args, options|
    resp = @api.request(
      method: :get,
      path: '/account/keys'
    )
    keys = JSON.load(resp.body)
    puts keys
  end
end

command 'keys:get' do |c|
  c.action do |args, options|
    resp = @api.request(
      method: :get,
      path: "/account/keys/#{args.first}"
    )
    key = JSON.load(resp.body)
    puts key
  end
end

command 'keys:delete' do |c|
  c.action do |args, options|
    key_id = args.first
    resp = @api.request(
      method: :delete,
      path: "/account/keys/#{key_id}"
    )
    case resp.status
    when 404 then puts "Key (id=#{app_id}) not found"
    when 500 then puts "Key (id=#{app_id}) cannot be deleted"
    when 204 then puts "Key (id=#{app_id}) deleted sucessfully"
    end
  end
end