module Mulukhiya
  module Rubicure
    extend Rake::DSL

    desc 'test all'
    task :test do
      TestCase.load
    end
  end
end
