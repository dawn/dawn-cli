require 'cli_spec_helper'

describe Dawn::CLI::App, :vcr do
  before :all do
    Dawn::CLI.selected_app = "app-test"
  end

  context ".create" do
    it "should create a new app without a name" do
      Dawn::CLI::App.create nil
    end

    it "should create a new app with a name" do
      Dawn::CLI::App.create "crispy-judge"
    end
  end

  context ".list" do
    it "should list all available apps" do
      Dawn::CLI::App.list
    end
  end

  context ".list_gears" do
    it "should list all gears for current app" do
      Dawn::CLI::App.list_gears
    end
  end

  context ".scale" do
    it "should modify the formation for the current app" do
      Dawn::CLI::App.scale("web" => ["+", 1])
    end
  end

  context ".run" do
    it "should run a command on current app" do
      Dawn::CLI::App.run(%w[bash --version])
    end

    it "should fail if no command is given" do
      Dawn::CLI::App.run(%w[])
    end
  end

  context ".logs" do
    it "should trail the current app's logs" do
      Dawn::CLI::App.logs([], false)
    end
  end

  context ".restart" do
    it "should restart current app" do
      Dawn::CLI::App.restart
    end
  end

  context ".delete" do
    before :all do
      Dawn::CLI.selected_app = "crispy-judge"
    end

    after :all do
      Dawn::CLI.selected_app = "app-test"
    end

    it "should delete current app" do
      Dawn::CLI::App.delete
    end
  end
end
