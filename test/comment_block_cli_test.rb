require File.dirname(__FILE__) + '/test_helper.rb'

class CommentBlockCLITest < Test::Unit::TestCase
  def setup
    @ruby = 'ruby'
    @ruby_opts = "-I#{$:.last}"
    @cli = File.join(File.dirname(__FILE__), '..', 'bin', 'comment_block')
    @file = fixtures 'example_hosts_file'
    @command = "#{@ruby} #{@ruby_opts} #{@cli} #{@file}"
    @original_data = File.read(@file)
  end
  
  def teardown
    File.open(@file, 'w') { |f| f.print @original_data }
  end
  
  def test_cli_comment_operation
    `#{@command} comment internal`
    assert(/^#internal/ =~ File.read(@file))
    assert(/^#external/ =~ File.read(@file))
    `#{@command} toggle external`
    assert(/^#internal/ =~ File.read(@file))
    assert(/^external/ =~ File.read(@file))
    `#{@command} uncomment external`
    assert(/^#internal/ =~ File.read(@file))
    assert(/^external/ =~ File.read(@file))
  end
end
