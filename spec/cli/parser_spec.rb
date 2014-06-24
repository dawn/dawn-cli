require 'cli_spec_helper'

describe Dawn::CLI do

  before :all do
    Dawn::CLI.no_operation = true
  end

  after :all do
    Dawn::CLI.no_operation = false
  end
#create
#ls
#ps
#login
#logs
  describe ".run" do
    context "when a given command does not exist" do
      it "should abort execution" do
        expect { Dawn::CLI.run(%w[hamburger]) }.to raise_error(SystemExit)
      end
    end

    context "when given a create command" do
      it "should accept command with no parameters" do
        expect(Dawn::CLI.run(%w[create])).to eq(:create)
      end

      it "should accept command with 1 parameter" do
        expect(Dawn::CLI.run(%w[create cheese-crunch])).to eq(:create)
      end
    end
  end

end
