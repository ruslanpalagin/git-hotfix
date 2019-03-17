module Branch
  class << self
    def current
      `git rev-parse --abbrev-ref HEAD`.gsub("\n", '')
    end

    def list
      raw_list.map{|b| b.gsub('*', '').strip }
    end

    def exists? name
      list.include? name
    end

    def task_name
      r = current.scan(/\/([^\/]+)$/)
      r = r[0][0] if r
      r
    rescue => e
      p e.to_s.red unless e.to_s == "undefined method `[]' for nil:NilClass"
      current
    end

    protected

    def raw_list
      list = `git branch`
      list.split("\n")
    end
  end
end

class Code
  class << self
    def has_changes?
      status = `git status`
      mapping = {
          'ru' => 'нечего коммитить',
          'en' => 'nothing to commit'
      }
      !status.include? mapping[Config.locale]
    end

    def has_untracked_files?
      update_index
      `git ls-files -o --directory --exclude-standard | sed q | wc -l`.to_i == 1
    end

    def has_unstaged_files?
      update_index
      `git diff-files --quiet --ignore-submodules -- || echo 1`.to_i == 1
    end

    def has_uncommited_changes?
      update_index
      `git diff-index --cached --quiet HEAD --ignore-submodules -- || echo 1`.to_i == 1 
    end

    private
  
    def update_index
      `git update-index -q --ignore-submodules --refresh`
    end
  end
end
