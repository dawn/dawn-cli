module Dawn
  module CLI
    class Application
      module Auth

        extend self

        # "save login details to .netrc"
        # usn = ask "Username: "
        # psw = password "Password: "
        def login(username, password)
          Dawn.authenticate(username: usn, password: psw)
          puts " ! login details have been saved to your .netrc"
        end

      end
    end
  end
end
