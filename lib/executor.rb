class Executor
  def execute(command)
    puts command
    %x[#{command}]
  end
end