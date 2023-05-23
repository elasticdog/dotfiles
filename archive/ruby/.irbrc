# Load colorized results
begin
  require 'rubygems'
  require 'wirble'
  Wirble.init
  Wirble.colorize

  # VALID COLORS
  #
  #  :nothing     :green         :light_purple
  #  :black       :light_blue    :purple
  #  :blue        :light_cyan    :red
  #  :brown       :light_gray    :white
  #  :cyan        :light_green   :yellow
  #  :dark_gray   :light_red
  #
  colors = Wirble::Colorize.colors.merge({
    # delimiter colors
    :comma              => :nothing,
    :refers             => :nothing,

    # container colors (hash and array)
    :open_hash          => :purple,
    :close_hash         => :purple,
    :open_array         => :purple,
    :close_array        => :purple,

    # object colors
    :open_object        => :purple,
    :object_class       => :white,
    :object_addr_prefix => :cyan,
    :object_line_prefix => :cyan,
    :close_object       => :purple,

    # symbol colors
    :symbol             => :cyan,
    :symbol_prefix      => :cyan,

    # string colors
    :open_string        => :purple,
    :string             => :brown,
    :close_string       => :purple,

    # misc colors
    :number             => :brown,
    :keyword            => :brown,
    :class              => :green,
    :range              => :nothing,
  })
  Wirble::Colorize.colors = colors
rescue LoadError
  puts "Error loading Wirble. Run 'sudo gem install wirble' to enable colorized results."
end


# Load custom prompts
begin # ANSI codes
  $ANSI_BLACK   = "\033[0;30m"
  $ANSI_GRAY    = "\033[1;30m"
  $ANSI_LGRAY   = "\033[0;37m"
  $ANSI_WHITE   = "\033[1;37m"
  $ANSI_RED     = "\033[0;31m"
  $ANSI_LRED    = "\033[1;31m"
  $ANSI_GREEN   = "\033[0;32m"
  $ANSI_LGREEN  = "\033[1;32m"
  $ANSI_BROWN   = "\033[0;33m"
  $ANSI_YELLOW  = "\033[1;33m"
  $ANSI_BLUE    = "\033[0;34m"
  $ANSI_LBLUE   = "\033[1;34m"
  $ANSI_PURPLE  = "\033[0;35m"
  $ANSI_LPURPLE = "\033[1;35m"
  $ANSI_CYAN    = "\033[0;36m"
  $ANSI_LCYAN   = "\033[1;36m"

  $ANSI_BACKBLACK  = "\033[40m"
  $ANSI_BACKRED    = "\033[41m"
  $ANSI_BACKGREEN  = "\033[42m"
  $ANSI_BACKYELLOW = "\033[43m"
  $ANSI_BACKBLUE   = "\033[44m"
  $ANSI_BACKPURPLE = "\033[45m"
  $ANSI_BACKCYAN   = "\033[46m"
  $ANSI_BACKGRAY   = "\033[47m"

  $ANSI_RESET      = "\033[0m"
  $ANSI_BOLD       = "\033[1m"
  $ANSI_UNDERSCORE = "\033[4m"
  $ANSI_BLINK      = "\033[5m"
  $ANSI_REVERSE    = "\033[7m"
  $ANSI_CONCEALED  = "\033[8m"

  $XTERM_SET_TITLE   = "\033]2;"
  $XTERM_END         = "\007"
  $ITERM_SET_TAB     = "\033]1;"
  $ITERM_END         = "\007"
  $SCREEN_SET_STATUS = "\033]0;"
  $SCREEN_END        = "\007"
end

begin
  if ENV['RAILS_ENV']
    name = "rails #{ENV['RAILS_ENV']}"
    colors = $ANSI_BACKBLUE + $ANSI_YELLOW
  else
    name = "ruby"
    colors = $ANSI_BACKPURPLE + $ANSI_YELLOW
  end

  if IRB and IRB.conf[:PROMPT]
    IRB.conf[:PROMPT][:SD] = {
      #:PROMPT_I => "#{colors}#{name}: %m #{ANSI_RESET}\n" \
      #           + "#{ANSI_LCYAN}>>#{ANSI_RESET} ",   # normal prompt
      :PROMPT_I => "#{$ANSI_LCYAN}>>#{$ANSI_RESET} ",   # normal prompt
      :PROMPT_S => "#{$ANSI_LCYAN}%l>#{$ANSI_RESET} ",  # string continuation
      :PROMPT_C => " #{$ANSI_LCYAN}>#{$ANSI_RESET} ",   # code continuation
      :PROMPT_N => " #{$ANSI_LCYAN}>#{$ANSI_RESET} ",   # code continuation too?
      :RETURN   => "\n#{$ANSI_BOLD}=> %s  #{$ANSI_RESET}\n",  # return value
      :AUTO_INDENT => true
    }
    IRB.conf[:PROMPT_MODE] = :SD
  end
end


# Copious output helper
def less
  spool_output('less')
end

def spool_output(spool_cmd)
  require 'stringio'
  $stdout, sout = StringIO.new, $stdout
  yield
  $stdout, str_io = sout, $stdout
  IO.popen(spool_cmd, 'w') do |f|
    f.write str_io.string
    f.flush
    f.close_write
  end
end


# Simple regular expression helper
def show_regexp(a, re)
  if a =~ re
    "#{$`}<<#{$&}>>#{$'}"
  else
    "no match"
  end
end


# Convenience method on regexp so you can do /an/.show_match("banana")
class Regexp
  def show_match(a)
    show_regexp(a, self)
  end
end


# Enable console logging
script_console_running = ENV.include?('RAILS_ENV') && IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers')
rails_running = ENV.include?('RAILS_ENV') && !(IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers'))
irb_standalone_running = !script_console_running && !rails_running

if script_console_running
  require 'logger'
  Object.const_set(:RAILS_DEFAULT_LOGGER, Logger.new(STDOUT))
end
