require 'cli_spec_helper'

describe Dawn::CLI::Release, :vcr do
  before :all do
    Dawn::CLI.selected_app = "release-test"
  end

  context ".list" do
    it "should list all releases for the current app" do
      Dawn::CLI::Release.list
    end
  end

  context ".add" do
    it "should add a new release to the current app" do
      Dawn::CLI::Release.add
    end
  end
end
