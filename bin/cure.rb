#!/usr/bin/env ruby
dir = File.expand_path('..', __dir__)
$LOAD_PATH.unshift(File.join(dir, 'app/lib'))
ENV['BUNDLE_GEMFILE'] = File.join(dir, 'Gemfile')

require 'mulukhiya/rubicure'
module Mulukhiya
  module Rubicure
    warn Package.full_name
    warn ''

  rescue => e
    warn e.message
    exit 1
  end
end
