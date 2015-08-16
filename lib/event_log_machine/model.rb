module EventLogMachine
  class Model
    def self.model_name(name)
      @name = name
      MachineRepository.register(name, self)
    end

    def self.states(state_list)
      state_list.each do |state|
        _machine.add_state(state)
      end
    end

    def self.initial_state(state, transition_name)
      _machine.add_state(state)
      _machine.add_transition(Machine::UninitializedState, state, transition_name)
    end

    def self.transition(start, finish, transition_name)
      _machine.add_transition(start, finish, transition_name)
    end

    def self._machine
      MachineRepository.get(@name)
    end
  end
end
