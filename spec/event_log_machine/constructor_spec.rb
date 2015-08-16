require "spec_helper"

describe EventLogMachine::Constructor do
  class User < EventLogMachine::Model
    model_name :user

    states [:active, :inactive, :logged_in, :deleted]

    initial_state :active, "Create active"

    transition :active, :logged_in, "Log in"
    transition :logged_in, :active, "Log out"
    transition :active, :inactive,  "Mark inactive"
    transition :inactive, :active,  "Mark active"
    transition :active, :deleted,   "Delete active user"
    transition :inactive, :deleted, "Delete inactive user"

    attr_reader :status, :events

    def initialize(status, events)
      @status, @events = status, events
    end
  end

  describe "create_from_events" do
    let(:constructor) { EventLogMachine::MachineRepository.constructor_for(:user) }

    it "constructs an object from a series of events" do
      events = ["Create active", "Log in", "Log out", "Delete active user"]

      user = constructor.create_from_events(events)

      expect( user.status ).to eq :deleted
    end

    it "can construct an object given out of order events" do
      events = ["Log in", "Log out", "Delete active user", "Create active"]

      user = constructor.create_from_events(events)

      expect( user.status ).to eq :deleted
      expect( user.events ).to eq ["Create active", "Log in", "Log out", "Delete active user"]
    end

    it "throws an error if no consistent history can be found" do
      events = ["Create active", "Log out"]

      expect{ constructor.create_from_events(events) }.to raise_error(EventLogMachine::NoConsistentHistory)
    end

    it "throws an error if multiple possible histories are found" do
      events = ["Create active", "Log in", "Log out", "Mark inactive", "Mark active"]

      expect{ constructor.create_from_events(events) }.to raise_error(EventLogMachine::MultipleConsistentHistories)
    end
  end
end
