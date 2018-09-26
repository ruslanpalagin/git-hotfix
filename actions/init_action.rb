
class InitAction
  class << self
    def call args, options
      cmds = []

      remote = args[1]
      if !remote
        print "remote is missing. Example: hf init git@github.com:r1dd1ck777/git-hotfix.git"
        return { cmds: cmds, danger: false }
      end

      source = "#{ROOT_DIR}/.gitignore.template"
      cmds << "cp #{source} .gitignore"
      cmds << "git init"
      cmds << "git add -A && git commit -a -m 'init'"
      cmds << "git checkout -b develop"
      cmds << "git checkout master"
      cmds << "git remote add origin #{remote}"
      cmds << "git push origin master"
      cmds << "git push origin develop"

      { cmds: cmds, danger: true }
    end

    protected
  end
end