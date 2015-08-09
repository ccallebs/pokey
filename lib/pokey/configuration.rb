class Pokey::Configuration
  attr_accessor :hook_dir, :hooks

  def initialize
    @hook_dir = "app/pokey"
    @hooks = []
  end

  def add_hook(&block)
    Pokey::Hooks.add(&block)
  end
end
