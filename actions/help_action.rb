
class HelpAction
  class << self
    def call args, options
      print "\nVersion: #{VERSION}".underlined + "\n\n"
      print "Examples:".bold + "\n\n"
      print 'hf 777' + "\n"
      print 'hf save "its a comment"' + "\n"
      print 'hf save master develop "its a comment"' + "\n"
      print 'hf deploy master develop "its a comment"' + "\n"
      print 'hf delete-merged' + "\n"
      print 'hf config' + "\n"
      print 'hf self-update [VERSION]' + "\n"
      print 'hf sync' + "\n"
      print 'hf reset' + "\n"
      print 'hf get' + "\n"
      print 'hf st' + "\n"
      print 'hf init [REMOTE_URL]' + "\n"
      print "\n\n"
      print "Options: ".bold + "\n\n"
      print 'No push: (--local|--l) prevents pushes to remote' + "\n"
      print 'Silent: (--quiet|--q) Skips some messages' + "\n"
      print 'Auto confirmation: (--yes|--y)' + "\n"
      print 'Always commit (todo rethink this option): (--ac)' + "\n"
      print 'Only print commands: (--echo)' + "\n"
      print "\n"

      { cmds: [], danger: false }
    end

    protected

  end
end