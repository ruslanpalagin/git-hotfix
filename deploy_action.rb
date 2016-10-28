
class DeployAction
  class << self
    def call args, options
      comment = comment(args)
      task = Context::Br.task_name
      merge_branches = merge_branches(args)
      cmds = []

      branch = Context::Br.current
      unless branch.include? 'hotfix'
        print "You are not in hotfix branch!\n"
        exit
      end

      Remote::Br.update

      if Context::Code.has_changes?
        cmds << "git add . && git commit -a -m '##{task} #{comment}' #{Remote::Br.exists?(branch) ? " && git pull origin #{branch} " : nil} #{options[:no_push] ? nil : "&& git push origin #{branch}"}"
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
        print "---|-------------------------------------------------------------|---\n"
        print "---|--------------------------DEPLOY-----------------------------|---\n"
        print "---|-------------------------------------------------------------|---\n"
        print "---|-----------------------from .hf.yml--------------------------|---\n"
        print "---|-------------------------------------------------------------|---\n"
      end

      cmds << "git checkout #{branch}" if merge_branches.any?
      { cmds: cmds, danger: true }
    end

    protected

    def merge_branches args
      branches = args[1..-1].select{|arg| arg != comment(args) }
      if branches.size == 0
        print "Deploy branches not specified." + "\n"
        print "Try something like $ hf deploy master 'foo' " + "\n"
        exit
      end
      branches
    end

    def comment args
      comment = args.last == 'deploy' || Context::Br.exists?(args.last) ? nil : args.last
      if comment.include?('"') || comment.include?("'")
        print "Invalid comment. Try to avoid ' and \" symbols or fix it in pull request =)" + "\n"
        exit
      end
      comment
    end

    def deploy_cmd merge_branch
      yml_file = PROJECT_DIR + '/.hf.yml'

      hash = YAML.load File.read(yml_file) if File.exists? yml_file

      if hash && hash['deploy'] && hash['deploy'][merge_branch] != ''
        "git checkout #{merge_branch} && #{hash['deploy'][merge_branch]}"
      end
    end
  end
end