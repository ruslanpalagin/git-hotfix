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

    def branch_dir
      hotfix? ? 'hotfix' : 'feature'
    end

    def get
      result = exists? ? data : {}
      result[:mode] ||= 'hotfix'
    end

    def main_branch
      hotfix? ? 'master' : 'develop'
    end

    def exists?
      File.exists? file_location
    end

    protected

    def data
      YAML.load(file_content) || {}
    end

    def file_location
      PROJECT_DIR + '/.hf.yml'
    end

    def file_content
      File.read(file_location)
    end
  end
end