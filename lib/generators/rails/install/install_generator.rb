require 'rails/generators'

module Pokey
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def copy_initializer
        template "initializer.rb.erb", "config/initializers/pokey.rb"
      end
    end
  end
end
