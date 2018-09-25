
class SelfUpdateAction
  class << self
    def call args, options
      checkout = ARGV[1] || :master
      dir = `ls -l /usr/bin/`.split("\n").detect{|symlink| symlink.include? 'git-hotfix' }
      dir = dir.scan(/\->\s(.*)\/hf/)[0][0]
      `cd '#{dir}' && git checkout #{checkout} && git pull origin #{checkout}`

      { cmds: [], danger: false }
    end

    protected

  end
end