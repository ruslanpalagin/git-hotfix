
class MyAction
  class << self
    def call args, options
      result = `git for-each-ref --sort=-committerdate refs/heads/`
                   .gsub(/(.*)refs\/heads\//, "")
                   .split("\n")
      puts result[0..20]

      exit
    end

    protected
  end
end