class DeleteMergedAction
  class << self
    def call args, options
      cmds = []

      print Remote::Br.update

      print `git checkout #{Config.main_branch}`
      print `git remote prune origin`

      locals, remotes = list
      locals.each do |br|
        cmds << "git branch -d #{br}"
      end

      remotes.each do |br|
        cmds << "git checkout #{br} && git checkout #{Config.main_branch} && git branch -d #{br} && git push origin --delete #{br}"
      end

      print `git remote prune origin`

      { cmds: cmds, danger: true }
    end

    protected

    def list
      all_possible_merged = `git branch -a --merged`.split("\n").map{|br| br.strip }
                         .select{|br| !(br.include?('master') || br.include?('dev')) }
                         .select{|br| br.include?('hotfix') || br.include?('feature') }
                         .map{|br| br.gsub('remotes/origin/', '') }
      # p all_possible_merged

      remotes = `git ls-remote --heads origin`.split("\n").map{|br| br.strip.scan(/refs\/heads\/(.*)/)[0][0] }
                    .select{|br| !(br.include?('master') || br.include?('dev')) }
                    .map{|br| br.gsub('refs/heads/', '') }

      remotes_merged = remotes.select{|br| all_possible_merged.include? br }
      # locals_merged = all_possible_merged.select{|br| !remotes.include? br }
      locals_merged = []

      return locals_merged, remotes_merged
    end

  end
end