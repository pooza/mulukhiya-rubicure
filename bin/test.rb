#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.join(File.expand_path('..', __dir__), 'app/lib'))

require 'mulukhiya/rubicure'
module Mulukhiya
  module Rubicure
    puts Package.full_name
    puts 'テストローダー'
    puts ''
    TestCase.load(ARGV.getopts('', 'cases:')['cases'])
  rescue => e
    warn e.message
    exit 1
  end
end
