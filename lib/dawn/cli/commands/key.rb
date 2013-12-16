command "key:add" do |c|
  c.action do |args, options|
    Dawn::Key.add
  end
end

command "key:list" do |c|
  c.action do |args, options|
    keys = Dawn::Key.all
    keys.each do |key|
      puts key
    end
  end
end

command "key:get" do |c|
  c.action do |args, options|
    key_id = args.first
    puts Dawn::Key.find(id: key_id)
  end
end

command "key:delete" do |c|
  c.action do |args, options|
    key_id = args.first
    Dawn::Key.destroy(id: key_id)
  end
end