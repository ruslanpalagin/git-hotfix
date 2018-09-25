
class CheckoutAction
  class << self
    def call args, options
      name = args.first
      new_branch = "#{Config.branch_dir}/#{name}"

      cmds = []

      unless Context::Br.current == new_branch
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

      if Context::Br.exists? new_branch
        cmds << "git checkout #{new_branch}"
      else
        cmds << "git checkout #{Config.main_branch}" unless Context::Br.current == Config.main_branch
        cmds << "git pull origin #{Config.main_branch}"
        cmds << "git checkout -b #{new_branch}"
      end

      cmds
    end
  end
end