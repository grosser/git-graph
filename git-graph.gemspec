$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
name = "git-graph"
require "#{name.gsub("-","/")}/version"

Gem::Specification.new name, Git::Graph::VERSION do |s|
  s.summary = "Make graphs from your git history"
  s.authors = ["Michael Grosser"]
  s.email = "michael@grosser.it"
  s.homepage = "http://github.com/grosser/#{name}"
  s.files = `git ls-files`.split("\n")
  s.license = "MIT"
  cert = File.expand_path("~/.ssh/gem-private-key-grosser.pem")
  if File.exist?(cert)
    s.signing_key = cert
    s.cert_chain = ["gem-public_cert.pem"]
  end
  s.executables = ["git-graph"]
  s.add_runtime_dependency "gchartrb"
end
