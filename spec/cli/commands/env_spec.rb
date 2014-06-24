require 'cli_spec_helper'

describe Dawn::CLI::Env, :vcr do
  before :all do
    Dawn::CLI.selected_app = "env-test"
  end

  context ".get" do
    it "should retrieve an ENV variable given a key" do
      Dawn::CLI::Env.get("HOSTNAME")
    end
  end

  context ".set" do
    it "should set an ENV variable given a Hash" do
      Dawn::CLI::Env.set("LemmeAtIt" => "maybe")
    end
  end

  context ".unset" do
    it "should remove an ENV variable given a key" do
      Dawn::CLI::Env.unset("LemmeAtIt")
    end
  end

end
