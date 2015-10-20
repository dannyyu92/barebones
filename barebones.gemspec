require "./lib/barebones/version"

Gem::Specification.new do |s|
  s.name        = "barebones"
  s.version     = "0.1.1"
  s.date        = "2015-10-19"
  s.licenses    = ['MIT']
  s.summary     = "Rails template generator"
  s.description = "Personal Rails template generator for Danny Yu"
  s.authors     = ["Danny Yu"]
  s.files       = `git ls-files -z`.split("\x0")
  s.executables = ["barebones"]
  s.homepage    = "https://github.com/dannyyu92/barebones"

  s.add_dependency 'rails', Barebones::RAILS_VERSION
end