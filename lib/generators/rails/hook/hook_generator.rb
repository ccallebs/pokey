require 'rails/generators'

module Pokey
  module Generators
    class HookGenerator < Rails::Generators::NamedBase
      desc "Generates a Pokey hook"
      check_class_collision suffix: "Hook"

      source_root File.expand_path("../templates", __FILE__)

      def create_hook_file
        template "hook.rb", "#{Pokey.hook_dir}/#{file_path.tr('/', '_')}_hook.rb"
      end
    end
  end
end
