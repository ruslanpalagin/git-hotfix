class SaveAction
  class << self
    def call args, options
      comment = comment(args)
      task = Branch.task_name
      merge_branches = merge_branches(args)
      cmds = []

      branch = Branch.current
      # unless branch.include? Config.task_branch_namespace
      #   print "You are not in #{Config.task_branch_namespace} branch!".yellow + "\n"
      #   exit
      # end

      Remote::Br.update

      if Code.has_changes?
        cmds << "git add -A && git commit -a -m '##{task} #{comment}' #{Remote::Br.exists?(branch) ? " && git pull origin #{branch} " : nil} #{options[:no_push] ? nil : "&& git push origin #{branch}"}"
      end

      merge_branches.each do |merge_branch|
        cmds << "git checkout #{merge_branch} && git pull origin #{merge_branch} && git merge #{branch} #{options[:no_push] ? nil : "&& git push origin #{merge_branch}"}"
      end

      cmds << "git checkout #{branch}" if merge_branches.any?
      { cmds: cmds, danger: true }
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