desc 'test all'
task :test do
  Mulukhiya::Rubicure::TestCase.load((ARGV.first&.split(/[^[:word:],]+/) || [])[1])
end
