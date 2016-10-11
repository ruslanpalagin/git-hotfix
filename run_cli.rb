class RunCli
  class << self
    def call cmds
      print "\n"
      print "Following commands will be executed:\n"
      print "\n"

      cmds = [cmds] unless cmds.is_a? Array
      cmds = cmds.select{|cmd| cmd != nil }
      cmds.each{|cmd| print cmd  + "\n"}

      print "\n"
      print 'Ok? (y/n) [y]:' + "\n"
      key = STDIN.gets.chomp
      if key == '' || key == 'y'
        exec cmds.join(' && ')
      end
    end
  end
end