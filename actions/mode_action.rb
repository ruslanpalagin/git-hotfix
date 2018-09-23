
class ModeAction
  class << self
    def call args, options
      cmds = []

      if !['feature', 'hotfix'].include?(args[1])
        print "Wrong new mode: #{args[1]}\nExample: 'hf mode feature' \n"
        return { cmds: cmds, danger: false }
      end

      print "current mode: #{Context::Br.mode(options)} \n"
      print "new mode: #{args[1]} \n"

      { cmds: cmds, danger: true }
    end

    protected


  end
end