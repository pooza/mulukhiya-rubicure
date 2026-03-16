#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.join(File.expand_path('..', __dir__), 'app/lib'))

require 'mulukhiya/rubicure'
module Mulukhiya
  module Rubicure
    if PumaDaemon.disable?
      warn "#{PumaDaemon.name}: disabled, skipping"
      exit 0
    end
    PumaDaemon.spawn!
  end
end
