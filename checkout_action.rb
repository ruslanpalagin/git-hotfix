
class CheckoutAction
  class << self
    def call args, options
      name = args.first
      new_branch = "hotfix/#{name}"

      cmds = []

      if Context::Br.current == new_branch
        cmds << "git merge master"
        return { cmds: cmds }
      end

      if Context::Br.exists? new_branch
        cmds << "git checkout #{new_branch}"
      else
        cmds << "git checkout master" unless Context::Br.current == 'master'
        cmds << "git checkout -b #{new_branch}"
      end

      { cmds: cmds }
    end

    protected
  end
end