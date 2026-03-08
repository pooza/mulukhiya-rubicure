module Mulukhiya
  module Rubicure
    extend Rake::DSL

    namespace :clasp do
      ['girls', 'series'].each do |name|
        namespace name do
          gas_dir = File.join(dir, 'gas', name)

          desc "push #{name} GAS script"
          task :push do
            Dir.chdir(gas_dir) {sh 'clasp push'}
          end

          desc "deploy #{name} GAS script"
          task deploy: :push do
            Dir.chdir(gas_dir) {sh 'clasp deploy'}
          end
        end
      end
    end
  end
end
