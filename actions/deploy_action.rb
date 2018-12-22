module DeployAction
  class << self
    def call args, options
      commit_message = comment(args)
      task_name = Branch.task_name
      merge_branches = merge_branches(args)
      cmds = []

      branch = Branch.current
      # unless branch.include? Config.task_branch_namespace
      #   print "You are not in #{Config.task_branch_namespace} branch!\n"
      #   exit
      # end

      Remote::Br.update

      cmds = cmds + cmds_before_deploy_commit

      if Code.has_changes? || options[:always_commit]
        cmds << "git add -A && git commit -a -m '#{SaveAction.commit_message(task_name, commit_message)}' #{Remote::Br.exists?(branch) ? " && git pull origin #{branch} " : nil} #{options[:no_push] ? nil : "&& git push origin #{branch}"}"
      end

      merge_branches.each do |merge_branch|
        cmds << "git checkout #{merge_branch} && git pull origin #{merge_branch} && git merge #{branch} #{options[:no_push] ? nil : "&& git push origin #{merge_branch}"}"
      end

      has_deploy = false
      merge_branches.each do |merge_branch|
        _deploy_cmd = deploy_cmd(merge_branch)
        cmds << deploy_cmd(merge_branch) if _deploy_cmd
        has_deploy = has_deploy || !!_deploy_cmd
      end

      if has_deploy
        print "---|-------------------------------------------------------------|---\n".bold
        print "---|--------------------------DEPLOY-----------------------------|---\n".bold
        print "---|-------------------------------------------------------------|---\n".bold
        print "---|-----------------------from .hf.yml--------------------------|---\n".bold
        print "---|-------------------------------------------------------------|---\n".bold
      end

      cmds << "git checkout #{branch}" if merge_branches.any?
      { cmds: cmds, danger: true }
    end

    protected

    def cmds_before_deploy_commit
      cmds = []
      before_deploy_commit_config = Config.get['before_deploy_commit']
      if before_deploy_commit_config != nil && before_deploy_commit_config != ''
        cmds << before_deploy_commit_config
      end

      cmds
    end

    def merge_branches args
      branches = args[1..-1].select{|arg| arg != comment(args) }
      if branches.size == 0
        print "Deploy branches not specified.".yellow + "\n"
        print "Try something like $ hf deploy master 'foo' ".yellow + "\n"
        exit
      end
      branches
    end

    def comment args
      comment = args.last == 'deploy' || Branch.exists?(args.last) ? nil : args.last
      if comment != nil && (comment.include?('"') || comment.include?("'"))
        print "Invalid comment. Try to avoid ' and \" symbols or fix it in pull request =)".yellow + "\n"
        exit
      end
      comment
    end

    def deploy_cmd merge_branch
      yml_file = Config.file_location

      hash = YAML.load File.read(yml_file) if File.exists? yml_file

      if hash && hash['deploy'] && hash['deploy'][merge_branch] != ''
        "git checkout #{merge_branch} && #{hash['deploy'][merge_branch]}"
      end
    end
  end
end