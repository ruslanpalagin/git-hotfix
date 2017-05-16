
# Monkey-patching String class
class String
  # Foreground Colors

  def black
    colorize(self, "\e[30m")
  end

  def red
    colorize(self, "\e[31m")
  end

  def green
    colorize(self, "\e[32m")
  end

  def yellow
    colorize(self, "\e[33m")
  end

  def blue
    colorize(self, "\e[34m")
  end

  def pur
    colorize(self, "\e[35m")
  end

  def cyan
    colorize(self, "\e[36m")
  end

  def white
    colorize(self, "\e[37m")
  end

  # Modifiers

  def bold
    colorize(self, "\e[1m")
  end

  def underlined
    colorize(self, "\e[4m")
  end

  private

  def colorize(text, color_code)
    if Config.colorize?
      "#{color_code}#{text}\e[0m"
    else
      text
    end
  end
end
