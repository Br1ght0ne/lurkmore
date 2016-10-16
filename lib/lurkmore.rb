# coding: utf-8

require 'tty-spinner'
require 'capybara/poltergeist'

# Main Lurkmore class
class Lurkmore
  LINK_RANDOM = 'http://lurkmore.to/%D0%A1%D0%BB%D1%83%D0%B6%D0%B5%D0%B1%D0%BD%D0%B0%D1%8F:Random'
  TERM_WIDTH = Integer(`tput cols`)

  RED = "\e[31m"
  GREEN = "\e[32m"
  RESET_COLOR = "\e[0m"

  # Gets a random article from http://lurkmore.to
  def self.random
    spinner = TTY::Spinner.new
    spinner.run do
      @session = Capybara::Session.new(:poltergeist)
      @session.visit(LINK_RANDOM)
    end
    begin
      if $stdout.tty?
        puts heading(colorcode(@session.first('.firstHeading').text.strip, GREEN))
      else
        puts heading(@session.first('.firstHeading').text.strip)
      end
      puts
      puts hr
      paragraphs = all_p
      paragraphs.each do |p|
        text = p.text.strip
        next if text.empty? || (text.split(' ').size < 10)
        puts wrap(text), hr
      end
    rescue Errno::EPIPE
      exit(74)
    end
  end

  # Wraps strings in terminal window
  def self.wrap(s, width=TERM_WIDTH)
    s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
  end

  # Finds all p tags on current _\@session_
  def self.all_p
    @session.all(:css, '.mw-content-ltr p')
  end

  # Returns a horizontal rule matching <em>TERM_WIDTH</em>
  def self.hr
    "-" * TERM_WIDTH
  end

  # Converts _head_ to a colorcoded by #colorcode heading
  def self.heading(head)
    half = ( TERM_WIDTH - Integer(head.size) ) / 2
    "-" * half + head + "-" * half
  end

  # Colorcodes _string_ with _code_
  def self.colorcode(string, code)
    code + string + RESET_COLOR
  end
end

