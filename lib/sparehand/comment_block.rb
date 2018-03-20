require 'stringio'

module Sparehand
  module CommentBlock
    @@operation = :toggle
    @@comment = '#'
    
    def self.process input, tag, operation = @@operation, comment = @@comment, output = nil
   
      unless output 
        output = StringIO.new('')
        return_output = true
      end
      
      state = :ignore
      
      input.each_line do |line|
        if line.strip == "#{comment}END #{tag}"
          state = :ignore
        end
       
        output.puts send(state, line, operation, comment)
        
        if line.strip == "#{comment}BEGIN #{tag}"
          state = :process_line
        end
      end
      
      return output.string if return_output
    end 
    
    def self.ignore line, *extra
      line
    end
    
    def self.process_line line, operation = @@operation, comment = @@comment
      if line =~ /^#{comment}/
        if operation == :comment
          line
        else
          line[comment.length..-1]
        end
      else
        if operation == :uncomment
          line
        else
          comment + line
        end
      end
    end
  end #CommentBlock
end #Sparehand