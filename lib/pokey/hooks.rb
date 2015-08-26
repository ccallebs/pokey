require 'pokey/helpers/inflector'

class Pokey::Hooks
  @@hooks = []

  def self.clear!
    @@hooks = []
  end

  def self.all
    @@hooks
  end

  def self.count
    @@hooks.length
  end

  def self.add(&block)
    hook = Pokey::Hook.new
    block.call(hook)
    @@hooks << hook if hook.valid?
  end

  def self.add_from_class(klass)
    return unless klass
    @@hooks << klass.new
  end

  def self.add_from_dir(directory)
    directory += "/" if directory[-1] != "/"

    Dir.glob("#{directory}*.rb").map(&File.method(:realpath)).each do |file_path|
      require file_path

      base_name = File.basename(file_path, ".rb")
      klass = Helpers::Inflector.constantize(base_name.split('_').collect(&:capitalize).join)
      add_from_class(klass)
    end
  end
end
