#!/usr/bin/env ruby
dir = File.expand_path('..', __dir__)
$LOAD_PATH.unshift(File.join(dir, 'app/lib'))
ENV['BUNDLE_GEMFILE'] = File.join(dir, 'Gemfile')

Dir.chdir(dir)
require 'mulukhiya/rubicure'
module Mulukhiya
  module Rubicure
    raise 'tool undefined' unless name = ARGV.first&.underscore
    puts Tool.create(name).body(ARGV)
  rescue => e
    warn e.message
    exit 1
  end
end
