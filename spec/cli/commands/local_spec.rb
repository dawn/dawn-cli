require 'cli_spec_helper'

describe Dawn::CLI::Local, :vcr do
  context ".health_check" do
    it "should verify that server is running" do
      Dawn::CLI::Local.health_check
    end
  end

  context ".whoami" do
    it "should print current user to console" do
      Dawn::CLI::Local.whoami
    end
  end
end
