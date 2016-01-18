require "./lib/barebones/version"
require "date"

Gem::Specification.new do |s|
  s.name        = "barebones"
  s.version     = "0.1.4.0"
  s.date        = Date.today.to_s
  s.licenses    = ['MIT']
  s.summary     = "Rails template generator"
  s.description = "A personal Rails template generator."
  s.authors     = ["Danny Yu"]
  s.files       = `git ls-files -z`.split("\x0")
  s.executables = ["barebones"]
  s.homepage    = "https://github.com/dannyyu92/barebones"

  s.add_dependency 'rails', Barebones::RAILS_VERSION
end