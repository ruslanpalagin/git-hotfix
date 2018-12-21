
class SyncAction
  class << self
    def call args, options
      cmds = []

      if Code.has_changes?
        print "Please commit all changes before SYNC action!".yellow + "\n"
        { cmds: cmds, danger: false }
      else
        cmds << "git checkout #{Config.source_branch} && git pull origin #{Config.source_branch}"
        cmds << "git checkout #{Branch.current} && git merge #{Config.source_branch}"
        { cmds: cmds, danger: true }
      end
    end

    protected


  end
end