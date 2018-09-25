
class SyncAction
  class << self
    def call args, options
      cmds = []

      if Context::Code.has_changes?
        print "Please commit all changes before SYNC action!".yellow + "\n"
        { cmds: cmds, danger: false }
      else
        cmds << "git checkout #{Config.main_branch} && git pull origin #{Config.main_branch}"
        cmds << "git checkout #{Context::Br.current} && git merge #{Config.main_branch}"
        { cmds: cmds, danger: true }
      end
    end

    protected


  end
end