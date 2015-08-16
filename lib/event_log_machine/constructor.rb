module EventLogMachine
  class Constructor
    def initialize(machine, klass)
      @machine, @klass = machine, klass
    end

    def create_from_events(events)
      status = nil
      valid_histories = []

      events.permutation do |history|
        begin
          status = @machine.walk_events(history)
        rescue InvalidTransition
        else
          valid_histories << history
        end
      end

      raise NoConsistentHistory if status.nil?

      raise MultipleConsistentHistories if valid_histories.length > 1

      @klass.new(status, valid_histories[0])
    end
  end
end
