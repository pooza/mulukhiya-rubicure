$LOAD_PATH.unshift(File.join(File.expand_path(__dir__), 'app/lib'))

require 'cure_api'
run CureAPI::Controller
