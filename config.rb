class Config
  class << self
    def call
      get
    end

    def hotfix?
      get[:mode] == 'hotfix'
    end

    def feature?
      get[:mode] == 'feature'
    end

    def get
      if exists?
        data
      else
        {}
      end
    end

    def main_branch
      hotfix? ? :master : :develop
    end

    protected

    def data
      YAML.load(file_content) || {}
    end

    def exists?
      File.exists? file_location
    end

    def file_location
      PROJECT_DIR + '/.hf.yml'
    end

    def file_content
      File.read(file_location)
    end
  end
end