require File.dirname(__FILE__) + '/test_helper.rb'
require 'sparehand/safe_modify'

class SafeModifyTest < Test::Unit::TestCase
  def setup
   @file = fixtures('safe_modify_data')
  end
  
  def test_problem_in_block_should_leave_original
    original = File.read @file
    begin
      File.safe_modify(@file) do |input, output|
        raise 'Error on write'
      end
    rescue Exception
    end
    
    assert_equal original, File.read(@file)
  end
  
  def test_should_load_and_modify_file
    File.safe_modify(@file) do |input, output|
      assert_equal File.read(@file), input.read
      output.print 'changed!'
    end 
    assert_equal 'changed!', File.read(@file)    
  end
end