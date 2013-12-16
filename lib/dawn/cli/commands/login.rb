command "login" do |c|
  c.action do |args, options|
    usn = ask "Username: "
    psw = password "Password: "
    Dawn.authenticate(username: usn, password: psw)
    say " ! login details have been saved to your .netrc"
  end
end