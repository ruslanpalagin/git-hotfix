class Config
  MAX_NESTING = 20

  class << self
    def call
      get
    end

    # @deprecated
    def hotfix?
      get['mode'] == 'hotfix'
    end

    def locale
      get['locale']
    end

    # TODO - change logic to => skip_colorize: true
    def colorize?
      get['colorize']
    end

    # @deprecated
    def feature?
      get['mode'] == 'feature'
    end

    # @deprecated
    def branch_dir
      hotfix? ? 'hotfix' : 'feature'
    end

    def get
      result = exists? ? data : {}
      result['mode'] = result['mode'] || 'hotfix'
      result['locale'] = result['locale'] || 'en'
      result['colorize'] = result['colorize'].nil? ^ !result['colorize'] ^ true
      result
    end

    def write(config)
      data = get.merge(config)
      File.write(file_location, "" + data.to_yaml)
    end

    def main_branch
      hotfix? ? 'master' : 'develop'
    end

    def exists?
      File.exists? file_location
    end

    def file_location
      MAX_NESTING.times do |i|
        dir_nesting = '/..' * i
        file = PROJECT_DIR + dir_nesting + '/.hf.yml'
        return file if File.exists? file
      end

      PROJECT_DIR + '/.hf.yml'
    end

    protected

    def data
      (YAML.load(file_content) || {})
    end

    def file_content
      File.read(file_location)
    end
  end
end