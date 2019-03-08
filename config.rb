class Config
  MAX_NESTING = 20

  class << self
    def call
      raise "deprecated"
      get
    end

    def locale
      get['locale']
    end

    def colorize?
      !get['skip_colorize']
    end

    def task_branch_namespace
      tpl = get['task_branch_name_tpl']
      tpl.gsub(":mode", get['mode'])
      tpl.gsub(":task_name", Branch.task_name)
    end

    def get
      result = exists? ? data : {}
      result['task_branch_name_tpl'] ||= '"{mode}/{task_name}"'
      result['commit_massage_tpl'] ||= '#{task_name}: {commit_message}'
      result['project_name'] ||= ''
      result['source_branch'] = result['source_branch'] || 'master'
      result['locale'] ||= 'en'
      result['mode'] = result['mode'] || 'feature'
      result
    end

    def write(config)
      data = get.merge(config)
      File.write(file_location, "" + data.to_yaml)
    end

    def source_branch
      get['source_branch']
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