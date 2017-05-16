module Context
  class Br
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
        r = current.scan(/\/([^\/]+)/)
        r = r[0][0] if r
        r
      rescue => e
        p e.to_s.red unless e.to_s == "undefined method `[]' for nil:NilClass"
        nil
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
    end
  end
end