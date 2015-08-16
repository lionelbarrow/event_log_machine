module EventLogMachine
  class MachineRepository
    @@machines = {}
    @@model_classes = {}

    def self.register(name, klass)
      @@machines[name] = Machine.new(name)
      @@model_classes[name] = klass
    end

    def self.get(name)
      @@machines.fetch(name)
    end

    def self.constructor_for(name)
      machine = @@machines.fetch(name)
      klass = @@model_classes.fetch(name)
      Constructor.new(machine, klass)
    end
  end
end
