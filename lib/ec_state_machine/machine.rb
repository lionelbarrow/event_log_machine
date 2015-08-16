module EcStateMachine
  class Machine
    UninitializedState = :_unitialized

    def initialize(name)
      @name = name
      @transitions = {}
      @graph = RGL::DirectedAdjacencyGraph.new

      @graph.add_vertex(UninitializedState)
    end

    def add_state(state)
      @graph.add_vertex(state)
    end

    def add_transition(start, finish, transition_name)
      @graph.add_edge(start, finish)
      @transitions[transition_name] = {:start => start, :finish => finish}
    end

    def walk_events(events)
      transitions = events.map { |e| @transitions.fetch(e) }
      current_state = UninitializedState

      transitions.each do |transition|
        next_state = transition.fetch(:finish)

        if current_state == transition.fetch(:start) && @graph.has_edge?(current_state, next_state)
          current_state = next_state
        else
          raise InvalidTransition.new("Cannot transition from #{current_state} to #{next_state}")
        end
      end

      current_state
    end
  end
end
