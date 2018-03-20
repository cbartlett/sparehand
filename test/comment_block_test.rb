require File.dirname(__FILE__) + '/test_helper.rb'
require 'sparehand/comment_block'
require 'stringio'

class CommentBlockTest < Test::Unit::TestCase
  @@input = <<EOF
uncommented
#BEGIN a
to be commented
#END a
EOF

  @@comment_expected = <<EOF
uncommented
#BEGIN a
#to be commented
#END a
EOF
   @@uncomment_expected = <<EOF
uncommented
#BEGIN a
to be commented
#END a
EOF
  
  def test_ignore_doesnt_change_line
    assert_equal('hi', Sparehand::CommentBlock.ignore('hi'))
  end
  
  def test_comment_operation_forces_comment
    assert_equal('#hi', process('hi', :comment))
    assert_equal('#hi', process('#hi', :comment))
  end
  
  def test_uncomment_operation_forces_uncomment
    assert_equal('hi', process('#hi', :uncomment))
    assert_equal('hi', process('hi', :uncomment))
  end
  
  def test_any_other_operation_causes_toggle
    assert_equal('hi', process('#hi', :toggle))
    assert_equal('#hi', process('hi', :something_other_than_toggle))
  end
  
  def test_comment_character_can_be_changed
    assert_equal('hi', process('//hi', :uncomment, '//')) 
    assert_equal('hi', process('//hi', :toggle, '//')) 
  end
  
  def process data, op, comment = '#'
    Sparehand::CommentBlock.process_line(data, op, comment)
  end
  
  def test_process_should_operate_between_blocks
    assert_equal(@@comment_expected, Sparehand::CommentBlock.process(@@input, 'a', :comment))
    assert_equal(@@comment_expected, Sparehand::CommentBlock.process(@@input, 'a', :toggle))
    assert_equal(@@uncomment_expected, Sparehand::CommentBlock.process(@@input, 'a', :uncomment))
  end
  
  def test_process_should_operate_on_streams_and_return_nil
    input = StringIO.new(@@input)
    output = StringIO.new
    assert_nil Sparehand::CommentBlock.process(@@input, 'a', :toggle, '#', output)
    assert_equal(@@comment_expected, output.string)
  end
end
