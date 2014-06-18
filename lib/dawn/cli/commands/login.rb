module Dawn
module CLI
class Application
def login_commands

command "login" do |c|
  c.syntax = "dawn login"
  c.description = "Login to dawn's API"

  c.action do |args, options|
    usn = ask "Username: "
    psw = password "Password: "
    Dawn.authenticate(username: usn, password: psw)
    say " ! login details have been saved to your .netrc"
  end
end

end
end
end
end
