module EventLogMachine
  class Result
    attr_reader :status, :history

    def initialize(success, status, history)
      @success, @status, @history = success, status, history
    end

    def success?
      @success
    end
  end
end
