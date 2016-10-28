class Config
  class << self
    def call
      if exists?
        get
      else
        {}
      end
    end

    def get
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