
class MyAction
  class << self
    def call args, options
      result = `git for-each-ref --sort=-committerdate refs/heads/`.gsub("refs/heads/", "")
      puts result
      exit
    end

    protected
  end
end