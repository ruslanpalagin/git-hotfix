module Remote
  class Br
    class << self
      def current
        raw_list.detect{|br| br.include? '*'}.gsub('*', '').strip
      end

      def list
        raw_list.map{|b| b.gsub('*', '').strip }
      end

      def exists? name
        list.include? name
      end

      def task_name
        current.scan(/\/([^\/]+)/)[0][0]
      end

      protected

      def raw_list
        list = `git branch`
        list.split("\n")
      end
    end
  end
end