require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/testtask'
require 'rake/packagetask'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/contrib/rubyforgepublisher'
require 'fileutils'

begin
  require 'hoe'
  include FileUtils
  require File.join(File.dirname(__FILE__), 'lib', 'sparehand', 'version')

  AUTHOR = "Mat Schaffer"  # can also be an array of Authors
  EMAIL = "mat.schaffer@gmail.com"
  DESCRIPTION = "A collection of utilities for system manipulations both from Ruby or CLI."
  GEM_NAME = "sparehand"
  RUBYFORGE_PROJECT = "phillyonrails"
  HOMEPATH = "http://#{RUBYFORGE_PROJECT}.rubyforge.org/sparehand"

  NAME = "sparehand"
  REV = File.read(".svn/entries")[/committed-rev="(d+)"/, 1] rescue nil
  VERS = ENV['VERSION'] || (Sparehand::VERSION::STRING + (REV ? ".#{REV}" : ""))
                          CLEAN.include ['**/.*.sw?', '*.gem', '.config']
  RDOC_OPTS = ['--quiet', '--title', "sparehand documentation",
      "--opname", "index.html",
      "--line-numbers", 
      "--main", "README",
      "--inline-source"]

  class Hoe
    def extra_deps 
      @extra_deps.reject { |x| Array(x).first == 'hoe' } 
    end 
  end

  # Generate all the Rake tasks
  # Run 'rake -T' to see list of generated tasks (from gem root directory)
  hoe = Hoe.new(GEM_NAME, VERS) do |p|
    p.author = AUTHOR 
    p.description = DESCRIPTION
    p.email = EMAIL
    p.summary = DESCRIPTION
    p.url = HOMEPATH
    p.rubyforge_name = RUBYFORGE_PROJECT if RUBYFORGE_PROJECT
    p.test_globs = ["test/**/*_test.rb"]
    p.clean_globs = CLEAN 
    
    p.changes = [ 'Added dependencies for rake and hoe to appease firebrigade.' ]
    p.extra_deps = [ 'rake' ]
  end
rescue LoadError
  desc 'Run the test suite.'
  task :test do
     system "ruby -Ilib test/test_all.rb"
  end
end
