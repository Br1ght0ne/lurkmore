# coding: utf-8

require 'tty-spinner'
require 'capybara/poltergeist'

# Main class for http://lurkmore.to
class Lurkmore
  # Link to random page
  LINK_RANDOM = 'http://lurkmore.to/%D0%A1%D0%BB%D1%83%D0%B6%D0%B5%D0%B1%D0%BD%D0%B0%D1%8F:Random'

  # Current terminal width
  TERM_WIDTH = Integer(`tput cols`)

  # @!group Color codes

  # Red code
  RED = "\e[31m"

  # Green code
  GREEN = "\e[32m"

  #Reset code
  RESET_COLOR = "\e[0m"

  # @!endgroup

  # Gets a random article from http://lurkmore.to
  # @example
  #   Lurkmore.random #=> ...
  # @note Sometimes throws a PhantomJS JavaScript error.
  def self.random
    spinner = TTY::Spinner.new
    spinner.run do
      begin
        @session = Capybara::Session.new(:poltergeist)
        @session.visit(LINK_RANDOM)
      rescue Capybara::Poltergeist::JavascriptError
        $stderr.puts "A JS error occured. Skipping..."
      end
    end
    begin
      if $stdout.tty?
        puts heading(colorcode(@session.first('.firstHeading').text.strip, GREEN))
      else
        puts heading(@session.first('.firstHeading').text.strip)
      end
      puts
      puts hr
      all_p.each do |p|
        text = p.text.strip
        next if text.empty? || (text.split(' ').size < 10)
        puts wrap(text), hr
      end
    rescue Errno::EPIPE
      exit(74)
    end
  end

  # Wraps strings according to #TERM_WIDTH

  # @param s [String] string to wrap
  # @return [String] wrapped string
  def self.wrap(s)
    s.gsub(/(.{1,#{TERM_WIDTH}})(\s+|\Z)/, "\\1\n")
  end

  # Finds all p tags on current _session_
  #
  # @return [Array] array of p tags
  def self.all_p
    @session.all(:css, '.mw-content-ltr p')
  end

  # Makes a horizontal rule
  #
  # @return [String] horizontal rule matching #TERM_WIDTH
  def self.hr
    "-" * TERM_WIDTH
  end

  # Creates a heading
  #
  # @param head [String] text to make heading from
  # @return [String] heading
  def self.heading(head)
    half = ( TERM_WIDTH - Integer(head.size) ) / 2
    "-" * half + head + "-" * half
  end

  # Colorcodes strings
  #
  # @param string [String] string to colorcode
  # @param code [String] color code
  # @return [String] colorcoded string
  def self.colorcode(string, code)
    code + string + RESET_COLOR
  end
end

