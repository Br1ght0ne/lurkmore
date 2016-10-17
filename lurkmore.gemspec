Gem::Specification.new do |s|
  s.name        = 'lurkmore'
  s.version     = '0.3.1'
  s.date        = '2016-10-17'
  s.summary     = 'Lurkmore:Random'
  s.description = 'Prints random articles from http://lurkmore.to'
  s.authors     = ['Alex Filonenko']
  s.email       = 'filalex77@gmail.com'
  s.files       = ['lib/lurkmore.rb', 'spec/lurkmore_spec.rb']
  s.executables << 'lurkmore'
  s.homepage    = 'http://github.com/filalex77/lurkmore/'
  s.license     = 'MIT'
  s.add_development_dependency 'rspec', '~> 3.5', '>= 3.5.0'
  s.add_development_dependency 'rake', '~> 11.2', '>= 11.2.2'
  s.add_development_dependency 'simplecov', '~> 0.12', '>= 0.12.0'
  s.add_development_dependency 'yard', '~> 0.9', '>= 0.9.5'
  s.add_runtime_dependency 'poltergeist', '~> 1.11', '>= 1.11.0'
  s.add_runtime_dependency 'tty-spinner', '~> 0.4', '>= 0.4.1'
end