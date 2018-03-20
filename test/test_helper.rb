require 'test/unit'
$: << File.join(File.dirname(__FILE__), '..', 'lib')

class Test::Unit::TestCase
  def fixtures file
    File.join(File.dirname(__FILE__), 'fixtures',  file)
  end
end
