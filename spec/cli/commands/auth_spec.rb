require 'cli_spec_helper'

describe Dawn::CLI::Auth, :vcr do

  context ".login" do
    it "should login using proper credentials" do
      Dawn::CLI::Auth.login("IceDragon", "creampuff")
    end

    it "should not login using invalid credentials" do
      expect { Dawn::CLI::Auth.login("SomeGuy", "withsomepassword") }.to raise_error(SystemExit)
    end
  end

end
