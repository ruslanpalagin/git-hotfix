class ExecCli
  class << self
    def call options
      cmds = options[:cmds]

      unless cmds.any?
        print "\n"
        print "Nothing to do. I'll go and make some coffee...\n"
        print "\n"
        return
      end

      options[:danger] = true if ENV['DANGER']

      if options[:danger]
        print "\n"
        print "Following commands will be executed:".bold + "\n"
        print "\n"
      end

      cmds = [cmds] unless cmds.is_a? Array
      cmds = cmds.select{|cmd| cmd != nil }
      cmds.each{|cmd| print cmd.green  + "\n"}

      if options[:danger]
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