module EventLogMachine
  class InvalidTransition < StandardError; end

  class NoConsistentHistory < StandardError; end

  class MultipleConsistentHistories < StandardError; end
end