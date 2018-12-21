class GetAction
  class << self
    def call args, options
      cmds = []

      if Code.has_changes?
        print "Please commit all changes before GET action!".yellow + "\n"
        { cmds: cmds, danger: false }
      else
        cmds << "git pull origin #{Branch.current}"
        { cmds: cmds, danger: false }
      end
    end

    protected
  end
end