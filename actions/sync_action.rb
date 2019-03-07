
class SyncAction
  class << self
    def call args, options
      cmds = []

      if Code.has_changes?
        print "Please commit all changes before SYNC action!".yellow + "\n"
        { cmds: cmds, danger: false }
      else
        cmds << "git checkout #{Config.source_branch} && git pull origin #{Config.source_branch}"
        cmds << "git checkout #{Branch.current}"
        cmds << "git pull origin #{Config.source_branch} || true"
        cmds << "git mergetool || true"
        if options[:clean]
          cmds << "echo 'Deleting meld .orig files'"
          cmds << "find . -type f -name '*.orig'"
          cmds << "find . -type f -name '*.orig' -delete"
        end
        { cmds: cmds, danger: true }
      end
    end

    protected


  end
end