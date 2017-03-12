class StAction
  class << self
    def call args, options
      cmds = []
      cmds << "git status"

      { cmds: cmds, danger: false }
    end

    protected
  end
end