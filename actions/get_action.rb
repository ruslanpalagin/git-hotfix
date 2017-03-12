class GetAction
  class << self
    def call args, options
      cmds = []

      if Context::Code.has_changes?
        print "Please commit all changes before GET action!\n"
        { cmds: cmds, danger: false }
      else
        cmds << "git pull origin #{Context::Br.current}"
        { cmds: cmds, danger: false }
      end
    end

    protected
  end
end