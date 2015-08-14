class Pokey::Configuration
  attr_accessor :hook_dir, :hooks, :run_on

  def initialize
    @hook_dir = "app/pokey"
    @hooks = []
    @run_on = [:development]
  end

  def add_hook(&block)
    Pokey::Hooks.add(&block)
  end
end
