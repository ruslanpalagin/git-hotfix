class ExecCli
  class << self
    def call(response, args, options)
      cmds = response[:cmds]

      if options[:echo]
        print cmds.join(' && ')
        return
      end

      unless cmds.any?
        if !options[:quiet]
          print "\n"
          print "Nothing to do. I am going to make some coffee...\n"
          print "\n"
        end
        return
      end

      response[:danger] = true if ENV['DANGER']
      response[:danger] = false if options[:yes]

      if response[:danger]
        print "\n"
        print "Following commands will be executed:".bold + "\n"
        print "\n"
      end

      cmds = [cmds] unless cmds.is_a? Array
      cmds = cmds.select{|cmd| cmd != nil }
      cmds.each{|cmd| print cmd.green  + "\n"}

      if response[:danger]
        print "\n"
        print 'Ok? (y/n) [y]:' + "\n"
        key = STDIN.gets.chomp
        if key == '' || key == 'y'
          exec cmds.join(' && ')
        end
      else
        exec cmds.join(' && ')
      end

    end
  end
end