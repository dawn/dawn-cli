require 'cli_spec_helper'

describe Dawn::CLI::Drain, :vcr do
  before :all do
    Dawn::CLI.selected_app = "drain-test"
  end

  context ".list" do
    it "should list all drains for current app" do
      Dawn::CLI::Drain.list
    end
  end

  context ".add" do
    it "should add a drain to the current app" do
      Dawn::CLI::Drain.add("flushing.io")
    end
  end

  context ".delete" do
    it "should remove a drain from current app" do
      Dawn::CLI::Drain.delete("flushing.io")
    end
  end
end
