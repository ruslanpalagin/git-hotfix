class SetModeAction
  class << self
    def call(args, options)
      cmds = []

      new_mode = args[1]

      if !['feature', 'hotfix'].include?(args[1])
        print "Wrong new mode: #{new_mode}\nExample: 'hf mode feature' \n"
        return { cmds: cmds, danger: false }
      end

      cmds << "hf set-mode--write #{new_mode} --quiet"
      cmds << "git commit -a -m '#hf set mode to #{new_mode}'"
      cmds << "git push origin #{Context::Br.current}"

      print "current mode: #{Context::Br.mode(options)} \n"
      print "new mode: #{args[1]} \n"

      { cmds: cmds, danger: true }
    end

    # private action
    def __write(args, options)
      Config.write({
                       'mode' => args[1]
                   })

      { cmds: [], danger: false }
    end

    protected
  end
end