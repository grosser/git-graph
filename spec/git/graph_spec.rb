require "spec_helper"

describe Git::Graph do
  it "has a VERSION" do
    Git::Graph::VERSION.should =~ /^[\.\da-z]+$/
  end
end
