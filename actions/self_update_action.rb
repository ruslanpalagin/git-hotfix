
class SelfUpdateAction
  class << self
    def call args, options
      checkout = args[1] || :master
      dir = `ls -l /usr/bin/`.split("\n").detect{|symlink| symlink.include? 'git-hotfix' }
      dir = dir.scan(/\->\s(.*)\/hf/)[0][0]
      cmd = "cd '#{dir}' && git checkout #{checkout} && git pull origin #{checkout}"

      if options[:echo]
        { cmds: [cmd], danger: false }
      else
        `#{cmd}`
      end
    end

    protected

  end
end