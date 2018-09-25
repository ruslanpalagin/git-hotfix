
class ConfigAction
  class << self
    def call args, options
      cmds = []

      unless Config.exists?
        source = "#{ROOT_DIR}/.hf.template.yml"
        cmds << "cp #{source} .hf.yml"
      end

      cmds << "nano .hf.yml"

      { cmds: cmds }
    end

    protected


  end
end