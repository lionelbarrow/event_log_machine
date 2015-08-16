module EventLogMachine
  class Constructor
    def initialize(machine, klass)
      @machine, @klass = machine, klass
    end

    def create_from_events(events)
      result = @machine.walk_events(events)
      return @klass.new(result.status, result.history) if result.success?

      status = nil
      valid_histories = []

      # Naively looping over permutations has O(n!) average case performance.
      # This can be made much better with a smarter exploration of the space,
      # but worst-case performance will still be O(n!)
      events.permutation do |history|
        result = @machine.walk_events(history)

        if result.success?
          valid_histories << history
          status = result.status
        end
      end

      raise NoConsistentHistory if valid_histories.length == 0

      raise MultipleConsistentHistories if valid_histories.length > 1

      @klass.new(status, valid_histories[0])
    end
  end
end
