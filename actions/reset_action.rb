class ResetAction
  class << self
    def call args, options
      cmds = []

      if Context::Code.has_changes?
        cmds << "git add -A && git reset --hard"
        { cmds: cmds, danger: true }
      else
        { cmds: cmds, danger: false }
      end
    end

    protected
  end
end