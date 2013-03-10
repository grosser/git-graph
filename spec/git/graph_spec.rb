require "spec_helper"
require "tmpdir"

describe Git::Graph do
  it "has a VERSION" do
    Git::Graph::VERSION.should =~ /^[\.\da-z]+$/
  end

  context "CLI" do
    def run(command, options={})
      result = `#{command}`
      raise "FAILED #{command}\n#{result}" if $?.success? == !!options[:fail]
      result
    end

    def graph(command)
      run "ruby #{Bundler.root.join("bin/git-graph")} #{command}"
    end

    before :all do
      run("rm -rf #{Bundler.root.join("tmp/parallel")}")
      run("cd #{Bundler.root.join("tmp")} && git clone git@github.com:grosser/parallel.git 2>&1")
    end

    around do |example|
      Dir.chdir(Bundler.root.join("tmp/parallel")) do
        run("git co master 2>&1")
        example.call
      end
    end

    it "shows help" do
      graph("--help").should include("-i, --interval INTERVAL")
    end

    it "shows version" do
      graph("--version").should include(Git::Graph::VERSION)
    end

    it "graphs years in csv without any arguments" do
      result = graph("'cat lib/parallel.rb | wc -l' 2>/dev/null")
      result.should include("2012-")
      result.should include("2011-")
    end

    it "graphs years in csv" do
      result = graph("--start 2013-01-01 'cat lib/parallel.rb | wc -l' 2>/dev/null")
      result.should == <<-EXPECTED.gsub(/^\s+/, "")
        Date,value
        2013-01-01,331
        2012-01-02,280
        2011-01-02,258
        2010-01-02,116
      EXPECTED
    end

    it "graphs weeks in csv" do
      result = graph("--start 2013-01-01 --end 2012-10-01 --interval week 'cat lib/parallel.rb | wc -l' 2>/dev/null")
      result.should == <<-EXPECTED.gsub(/^\s+/, "")
        Date,value
        2013-01-01,331
        2012-12-25,331
        2012-12-18,331
        2012-12-11,310
        2012-12-04,310
        2012-11-27,310
        2012-11-20,301
        2012-11-13,296
        2012-11-06,296
        2012-10-30,296
        2012-10-23,296
        2012-10-16,296
        2012-10-09,296
        2012-10-02,289
      EXPECTED
    end

    it "fills in missing values with the last value" do
      # this file is not present pre 2011 -> error
      result = graph("--start 2013-01-01 'wc -l lib/parallel/version.rb' 2>/dev/null")
      result.should == <<-EXPECTED.gsub(/^\s+/, "")
        Date,value
        2013-01-01,3
        2012-01-02,3
        2011-01-02,3
        2010-01-02,3
      EXPECTED
    end

    it "generates a chart" do
      result = graph("--start 2013-01-01 --output chart 'cat lib/parallel.rb | wc -l' 2>/dev/null")
      result.should include("http://chart.apis.google.com/chart?")
      result.should include("")
    end

    it "returns to original commit after run" do
      graph("--start 2013-01-01 'cat lib/parallel.rb | wc -l' 2>/dev/null")
      run("git branch | grep '*'").should == "* master\n"
    end

    it "can bundle" do
      result = graph(%Q{--bundle --start 2013-01-01 '(time -p bundle exec ruby -e "sleep 0.1") 2>&1 | grep real | cut -d " " -f 2' 2>&1})
      result.should =~ /2013-01-01,\d\.\d+.*2012-01-02,\d\.\d+.*2011-01-02,\d\.\d+.*2010-01-02,\d\.\d+/m
    end
  end
end
