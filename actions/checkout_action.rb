
class CheckoutAction
  class << self
    def call args, options
      name = args.first
      new_branch = "#{Config.task_branch_namespace}/#{name}"

      cmds = []

      unless Branch.current == new_branch
        cmds = cmds + goto(new_branch)
      end

      print Remote::Br.update
      if Remote::Br.exists? new_branch
        cmds << "git pull origin #{new_branch}"
      end

      { cmds: cmds }
    end

    protected

    def goto new_branch
      cmds = []

      if Branch.exists? new_branch
        cmds << "git checkout #{new_branch}"
      else
        cmds << "git checkout #{Config.source_branch}" unless Branch.current == Config.source_branch
        cmds << "git pull origin #{Config.source_branch}"
        cmds << "git checkout -b #{new_branch}"
      end

      cmds
    end
  end
end