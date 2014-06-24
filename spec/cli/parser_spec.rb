require 'cli_spec_helper'

describe Dawn::CLI do
  before :all do
    Dawn::CLI.no_operation = true
  end

  after :all do
    Dawn::CLI.no_operation = false
  end

  describe ".run" do
    context "when a given command does not exist" do
      it "should abort execution" do
        expect { Dawn::CLI.run(%w[hamburger]) }.to raise_error(SystemExit)
      end
    end

    context "when given a `create` command" do
      it "should accept command without parameters" do
        expect(Dawn::CLI.run(%w[create])).to eq(:create)
      end

      it "should accept command with 1 parameter" do
        expect(Dawn::CLI.run(%w[create cheese-crunch])).to eq(:create)
      end
    end

    context "when given a `ls` command" do
      it "should accept command without parameters" do
        expect(Dawn::CLI.run(%w[ls])).to eq(:list)
      end
    end

    context "when given a `ps` command" do
      it "should accept command without parameters" do
        expect(Dawn::CLI.run(%w[ps])).to eq(:list_gears)
      end
    end

    ## login will not be tested since it requires user interaction

    context "when given a `logs` command" do
      it "should accept command without parameters" do
        expect(Dawn::CLI.run(%w[logs])).to eq(:logs)
      end
    end

    context "when given an `app` command" do
      it "should accept command without parameters" do
        Dawn::CLI.run(%w[app])
      end

      it "should default to list" do
        expect(Dawn::CLI.run(%w[app])).to eq(:list)
      end

      context "delete" do
        it "should accept without parameters" do
          expect(Dawn::CLI.run(%w[app delete])).to eq(:delete)
        end
      end

      context "restart" do
        it "should accept without parameters" do
          expect(Dawn::CLI.run(%w[app restart])).to eq(:restart)
        end
      end

      context "scale" do
        it "should not accept without parameters" do
          expect { Dawn::CLI.run(%w[app scale]) }.to raise_error(SystemExit)
        end

        it "should accept with parameters" do
          expect(Dawn::CLI.run(%w[app scale web+1])).to eq(:scale)
        end
      end
    end

    context "when given a `domain` command" do
      it "should accept command without parameters" do
        Dawn::CLI.run(%w[domain])
      end

      it "should default to list" do
        expect(Dawn::CLI.run(%w[domain])).to eq(:list)
      end

      context "add" do
        it "should not accept without parameters" do
          expect { Dawn::CLI.run(%w[domain add]) }.to raise_error(SystemExit)
        end

        it "should accept with parameters" do
          expect(Dawn::CLI.run(%w[domain add http://alliswell.io])).to eq(:add)
        end
      end

      context "delete" do
        it "should not accept without parameters" do
          expect { Dawn::CLI.run(%w[domain delete]) }.to raise_error(SystemExit)
        end

        it "should accept with parameters" do
          expect(Dawn::CLI.run(%w[domain delete http://alliswell.io])).to eq(:delete)
        end
      end
    end

    context "when given a `drain` command" do
      it "should accept command without parameters" do
        Dawn::CLI.run(%w[drain])
      end

      it "should default to list" do
        expect(Dawn::CLI.run(%w[drain])).to eq(:list)
      end

      context "add" do
        it "should not accept without parameters" do
          expect { Dawn::CLI.run(%w[drain add]) }.to raise_error(SystemExit)
        end

        it "should accept with parameters" do
          expect(Dawn::CLI.run(%w[drain add http://alliswell.io])).to eq(:add)
        end
      end

      context "delete" do
        it "should not accept without parameters" do
          expect { Dawn::CLI.run(%w[drain delete]) }.to raise_error(SystemExit)
        end

        it "should accept with parameters" do
          expect(Dawn::CLI.run(%w[drain delete http://alliswell.io])).to eq(:delete)
        end
      end
    end

    context "when given an `env` command" do
      it "should accept command without parameters" do
        Dawn::CLI.run(%w[env])
      end

      it "should default to list" do
        expect(Dawn::CLI.run(%w[env])).to eq(:list)
      end

      context "get" do
        it "should not accept without parameters" do
          expect { Dawn::CLI.run(%w[env get]) }.to raise_error(SystemExit)
        end

        it "should accept with parameter" do
          expect(Dawn::CLI.run(%w[env get HOSTNAME])).to eq(:get)
        end

        it "should accept with multiple parameters" do
          expect(Dawn::CLI.run(%w[env get HOSTNAME BREAD EGGS AND CHEESE])).to eq(:get)
        end
      end

      context "set" do
        it "should not accept without parameters" do
          expect { Dawn::CLI.run(%w[env set]) }.to raise_error(SystemExit)
        end

        it "should accept with parameter" do
          expect(Dawn::CLI.run(%w[env set HOSTNAME=kana])).to eq(:set)
        end

        it "should accept with multiple parameters" do
          expect(Dawn::CLI.run(%W[env set HOSTNAME=kana BREAD=wheat EGGS=3 AND="YEAH" CHEESE="the\sblue\skind"])).to eq(:set)
        end
      end

      context "unset" do
        it "should not accept without parameters" do
          expect { Dawn::CLI.run(%w[env unset]) }.to raise_error(SystemExit)
        end

        it "should accept with parameter" do
          expect(Dawn::CLI.run(%w[env unset HOSTNAME])).to eq(:unset)
        end

        it "should accept with multiple parameters" do
          expect(Dawn::CLI.run(%w[env unset HOSTNAME BREAD EGGS AND CHEESE])).to eq(:unset)
        end
      end
    end

    context "when given a `key` command" do
      it "should accept command without parameters" do
        Dawn::CLI.run(%w[key])
      end

      it "should default to list" do
        expect(Dawn::CLI.run(%w[key])).to eq(:list)
      end

      context "add" do
        it "should accept without parameters" do
          expect(Dawn::CLI.run(%w[key add])).to eq(:add)
        end
      end

      context "delete" do
        it "should not accept without parameters" do
          expect { Dawn::CLI.run(%w[key delete]) }.to raise_error(SystemExit)
        end

        it "should accept with parameters" do
          expect(Dawn::CLI.run(%w[key delete 14])).to eq(:delete)
        end
      end

      context "get" do
        it "should not accept without parameters" do
          expect { Dawn::CLI.run(%w[key get]) }.to raise_error(SystemExit)
        end

        it "should accept with parameters" do
          expect(Dawn::CLI.run(%w[key get 13])).to eq(:get)
        end
      end
    end

    context "when given a `release` command" do
      it "should accept command without parameters" do
        Dawn::CLI.run(%w[release])
      end

      it "should default to list" do
        expect(Dawn::CLI.run(%w[release])).to eq(:list)
      end

      context "add" do
        it "should accept without parameters" do
          expect(Dawn::CLI.run(%w[release add])).to eq(:add)
        end
      end
    end

    ## not sure how to test run
    context "when given a `run` command" do
      it "should accept command without parameters" do
        Dawn::CLI.run(%w[run])
      end

      it "should default to list" do
        expect(Dawn::CLI.run(%w[run])).to eq(:run)
      end
    end

    context "when given a `health-check` command" do
      it "should accept command without parameters" do
        expect(Dawn::CLI.run(%w[health-check])).to eq(:health_check)
      end
    end
  end
end
