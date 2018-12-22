module CheckoutAction
  class << self
    def call(args, options)
      task_name = args.first
      new_branch = task_branch_name(task_name)

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

    def task_branch_name(task_name)
      config = Config.get
      tpl = config['task_branch_name_tpl']
      tpl = tpl.gsub('{mode}', config['mode'])
      tpl = tpl.gsub('{task_name}', task_name)
      tpl
    end

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