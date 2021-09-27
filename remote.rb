module Remote
  class Br
    class << self

      def update
        `git remote update origin`
      end

      def exists? name
        raw_list.detect{|br_name| br_name.end_with? name } != nil
      end

      protected

      def raw_list
        list = `git branch -a`
        list.split("\n").map{|b| b.strip }.select{|br_name| br_name.include? 'remotes/' }
      end
    end
  end
end