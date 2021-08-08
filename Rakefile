dir = File.expand_path(__dir__)
$LOAD_PATH.unshift(File.join(dir, 'app/lib'))
ENV['BUNDLE_GEMFILE'] = File.join(dir, 'Gemfile')

require 'mulukhiya/rubicure'
ENV['RAKE'] = Mulukhiya::Rubicure::Package.full_name
Mulukhiya::Rubicure.load_tasks
