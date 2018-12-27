module SaveAction
  class << self
    def call(args, options)
      commit_message = comment(args)
      task_name = Branch.task_name
      merge_branches = merge_branches(args)
      cmds = []

      current_branch = Branch.current
      # unless branch.include? Config.task_branch_namespace
      #   print "You are not in #{Config.task_branch_namespace} branch!".yellow + "\n"
      #   exit
      # end

      Remote::Br.update

      if Code.has_changes?
        cmds << "git add -A && git commit -a -m '#{commit_message(task_name, commit_message)}' #{Remote::Br.exists?(current_branch) ? " && git pull origin #{current_branch} " : nil} #{options[:no_push] ? nil : "&& git push origin #{current_branch}"}"
      else
        cmds << "#{Remote::Br.exists?(current_branch) ? "git pull origin #{current_branch} " : nil}"
        cmds << "#{options[:no_push] ? nil : "git push origin #{current_branch}"}"
      end

      merge_branches.each do |merge_branch|
        cmds << "git checkout #{merge_branch} && git pull origin #{merge_branch} && git merge #{current_branch} #{options[:no_push] ? nil : "&& git push origin #{merge_branch}"}"
      end

      cmds << "git checkout #{current_branch}" if merge_branches.any?
      { cmds: cmds, danger: true }
    end

    # public helper - re-using in deploy action
    def commit_message(task_name, commit_message)
      config = Config.get
      tpl = config['commit_massage_tpl']
      p tpl
      p config
      p task_name
      tpl = tpl.gsub('{project_name}', config['project_name'])
      tpl = tpl.gsub('{task_name}', task_name)
      tpl = tpl.gsub('{commit_message}', commit_message)
      tpl
    end

    protected

    def merge_branches args
      branches = args[1..-1].select{|arg| arg != comment(args) }
      branches
    end

    def comment args
      comment = args.last == 'deploy' || Branch.exists?(args.last) ? nil : args.last
      if comment != nil && (comment.include?('"') || comment.include?("'"))
        print "Invalid comment. Try to avoid ' and \" symbols or fix it in a pull request =)".red + "\n"
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