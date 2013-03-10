require "spec_helper"

describe GitGraph do
  it "has a VERSION" do
    GitGraph::VERSION.should =~ /^[\.\da-z]+$/
  end
end
