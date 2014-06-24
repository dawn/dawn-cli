require 'cli_spec_helper'

describe Dawn::CLI::Domain, :vcr do
  before :all do
    Dawn::CLI.selected_app = "domain-test"
  end

  context ".list" do
    it "should list all domains for current app" do
      Dawn::CLI::Domain.list
    end
  end

  context ".add" do
    it "should add a domain to the current app" do
      Dawn::CLI::Domain.add("itwasadomain.io")
    end
  end

  context ".delete" do
    it "should delete a domain to the current app" do
      Dawn::CLI::Domain.delete("cc-rushers.io")
    end
  end
end
