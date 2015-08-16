module EventLogMachine
  class NoConsistentHistory < StandardError; end

  class MultipleConsistentHistories < StandardError; end
end
