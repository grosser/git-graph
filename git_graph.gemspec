$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
name = "git_graph"
require "#{name.gsub("-","/")}/version"

Gem::Specification.new name, GitGraph::VERSION do |s|
  s.summary = "Make graphs from your git history"
  s.authors = ["Michael Grosser"]
  s.email = "michael@grosser.it"
  s.homepage = "http://github.com/grosser/#{name}"
  s.files = `git ls-files`.split("\n")
  s.license = "MIT"
  s.signing_key = File.expand_path("~/.ssh/gem-private_key.pem")
  s.cert_chain = ["gem-public_cert.pem"]
end
