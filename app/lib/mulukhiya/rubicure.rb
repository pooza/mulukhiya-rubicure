require 'bundler/setup'
require 'mulukhiya/rubicure/refines'

module Mulukhiya
  module Rubicure
    using Refines

    def self.dir
      return File.expand_path('../../..', __dir__)
    end

    def self.loader
      config = YAML.load_file(File.join(dir, 'config/autoload.yaml'))
      loader = Zeitwerk::Loader.new
      loader.inflector.inflect(config['inflections'])
      loader.push_dir(File.join(dir, 'app/lib'))
      loader.collapse('app/lib/mulukhiya/rubicure/*')
      return loader
    end

    def self.setup_debug
      Ricecream.disable
      return unless Environment.development?
      Ricecream.enable
      Ricecream.include_context = true
      Ricecream.colorize = true
      Ricecream.prefix = "#{Package.name} | "
      Ricecream.define_singleton_method(:arg_to_s, proc {|v| PP.pp(v)})
    end

    def self.load_tasks
      Dir.glob(File.join(dir, 'app/task/*.rb')).each do |f|
      require f
    end
  end

    Bundler.require
    loader.setup
    setup_debug
  end
end
