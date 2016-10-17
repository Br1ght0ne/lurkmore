require 'rubygems'
require 'rspec/core/rake_task'

task default: %w[spec build]

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
  t.rspec_opts = '--format documentation'
  # t.rspec_opts << ' more options'
end

task :build do
  system('gem build lurkmore.gemspec')
end