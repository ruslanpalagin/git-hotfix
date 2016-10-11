
class DeployAction
  class << self
    def call args, options
      branch = Context::Br.current
      unless branch.include? 'hotfix'
        print "You are not in hotfix branch!\n"
        exit
      end

      task = Context::Br.task_name
      comment = comment(args)
      merge_branches = merge_branches(args)
      cmds = []

      if Context::Code.has_changes?
        cmds << "git add . && git commit -a -m '##{task} #{comment}' #{options[:no_push] ? nil : "&& git push origin #{branch}"}"
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
      cmds
    end

    protected

    def merge_branches args
      args[1..-1].select{|arg| arg != comment(args) }
    end

    def comment args
      args.last == 'save' || Context::Br.exists?(args.last) ? nil : args.last
    end
    
    def deploy_cmd merge_branch
      yml_file = PROJECT_DIR + '/.hf.yml'

      if File.exists? yml_file
        hash = YAML.load File.read(yml_file)
        hash['deploy'][merge_branch] if hash['deploy'] && hash['deploy'][merge_branch] != ''
      end
    end
  end
end