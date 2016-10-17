
class CheckoutAction
  class << self
    def call args, options
      name = args.first
      new_branch = "hotfix/#{name}"

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
        cmds << "git checkout master" unless Context::Br.current == 'master'
        cmds << "git pull origin master"
        cmds << "git checkout -b #{new_branch}"
      end

      cmds
    end
  end
end