module ConfigAction
  class << self
    def call args, options
      cmds = []

      unless Config.exists?
        source = "#{ROOT_DIR}/.hf.template.yml"
        cmds << "cp #{source} .hf.yml"
      end

      cmds << "nano #{Config.file_location}"

      { cmds: cmds }
    end

    protected
  end
end