#
# This script checks Chef docs topics against heading conventions
# (described below)
#
# The input comes from stdin as a list of files (one per line) to be checked.
#

H1REGEX = /\A=+\s*\z/
H2REGEX = /\A=+\s*\z/
H3REGEX = /\A-+\s*\z/
H4REGEX = /\A\++\s*\z/
H5REGEX = /\A\^+\s*\z/
BLANKREGEX = /\A\s*\z/
TITLEREGEX = /[A-Za-z]+/
SECTIONCHARS = ['=', '-', '`', ':', '.', '\'', '"', '~', '^', '_', '*', '+', '#'].freeze

# Check that line is a valid section title
def check_title(file, lineNo, line)
  fail_at(file, lineNo, "invalid title - #{line}") unless line.match(TITLEREGEX)
end

# Is line a section adornment?
def is_section(line)
  # must start with one of the section chars and consist of only that char
  line.length > 5 && SECTIONCHARS.include?(line[0]) && line.strip.chars.to_a.uniq.length == 1
end

# Print error
def fail_at(id, lineNo, errMsg)
  raise "In #{id}:#{lineNo}, #{errMsg}"
end

#
# check_headings
#
# The function validates conventions used by chef-docs. It does not
# handle generalized restructuredText, which has a more complicated
# annotation scheme for headings. Sections in rst are explained in
# http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#sections.
#
# It checks that that:
#
# - H1 headings have overline *and* underline adornment using the "=" character.
#
# - Section headings other H1 use underline adornment only.
#
# - H2 headings use the "=" character for their underline adornment.
#
# - H3 headings use the "-" character for their underline adornment.
#
# - H4 headings use the "+" character for their underline adornment.
#
# - H5 headings use the "^" character for their underline adornment.
#
# - Nesting is consecutve; for example, H3 can follow H2 but not H1
#
def check_headings(id, instr)
  # parsing state
  h1Mode = 0       # H1 states: 0=ready, 1=expecting title, 2=expecting underline
  lineNo = 1       # current line number
  prevLine = ''    # contents of the previous line
  level = 0        # current heading level (1=H1, 2=H2, etc.)

  instr.each_line do |line|
    # H1 overline
    if h1Mode == 0 && prevLine.match(BLANKREGEX) && line.match(H1REGEX)
      h1Mode = 1 # consume overline and enter H1 "expecting title" mode
      level = 1

    # H1 title
    elsif h1Mode == 1
      check_title(id, lineNo, line)
      h1Mode = 2 # enter H1 "expecting underline" mode

    # H1 underline
    elsif h1Mode == 2
      fail_at(id, lineNo, "expected H1 underline, saw #{line}") unless line.match(H1REGEX)
      h1Mode = 0 # exit H1 parsing mode

    # H2
    elsif line.match(H2REGEX)
      fail_at(id, lineNo, 'H2 seen without H1') if level < 1
      check_title(id, lineNo, prevLine)
      level = 2

    # H3
    elsif line.match(H3REGEX)
      fail_at(id, lineNo, 'H3 seen without H2') if level < 2
      check_title(id, lineNo, prevLine)
      level = 3

    # H4
    elsif line.match(H4REGEX)
      fail_at(id, lineNo, 'H4 seen without H3') if level < 3
      check_title(id, lineNo, prevLine)
      level = 4

    # H5
    elsif line.match(H5REGEX)
      fail_at(id, lineNo, 'H5 seen without H4') if level < 4
      check_title(id, lineNo, prevLine)
      level = 5

    # all other lines
    else
      fail_at(id, lineNo, "unexpected section break #{line}") if is_section(line)

    end

    lineNo += 1
    prevLine = line
  end
end

#
# check_all_headings
#
def check_all_headings(topics)
  topics.each_line do |fileNameLine|
    fileName = fileNameLine.strip
    File.open(fileName, 'r') do |topic|
      check_headings(fileName, topic)
    end
  end
end

check_all_headings($stdin.read)
