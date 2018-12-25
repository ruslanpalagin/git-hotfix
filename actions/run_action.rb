module RunAction
  class << self
    def call(args, options)
      cmds = []

      script_key = args[1]
      config = Config.get()

      scripts = config['run'] || {}
      script = scripts[script_key]
      cmds << script

      { cmds: cmds, danger: true }
    end

    protected
  end
end