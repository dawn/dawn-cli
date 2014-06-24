require 'cli_spec_helper'
require "sshkey"

describe Dawn::CLI::Key, :vcr do
  context ".list" do
    it "should list all keys deployed" do
      Dawn::CLI::Key.list
    end
  end

  context ".add" do
    it "should add existing id_rsa" do
      Dawn::CLI::Key.add
    end
  end

  context ".get" do
    it "should retrieve a key by id" do
      key = Dawn::Key.all.last
      Dawn::CLI::Key.get(key.id)
    end
  end

  context ".delete" do
    it "should delete a key by id" do
      key = Dawn::Key.all.last
      Dawn::CLI::Key.delete(key.id)
    end
  end
end
