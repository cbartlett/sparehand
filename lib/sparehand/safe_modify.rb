require 'fileutils'

class << File
  def safe_modify original
    path = File.dirname(original)  
    temp_name = '.' + File.basename(original) + '.tmp'
    temp_path = File.join(path, temp_name)

    File.open(original) do |input|
      File.open(temp_path, 'w') do |output|
        yield input, output
      end
    end

    File.delete original
    File.rename temp_path, original
  end
end