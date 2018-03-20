Dir[File.join(File.dirname(__FILE__), '**', '*_test.rb')].each do |test_case|
  require test_case if File.file? test_case
end