#
# allinone.rb - creates combined topics runbook.html and resources.html
#

MINADORNMENT = 53 # minimum number of adornment chars used in chef-docs

H2CHAR = '='.freeze
H3CHAR = '-'.freeze
H4CHAR = '+'.freeze
H5CHAR = '^'.freeze

H1REGEX = /\A=+\s*\z/
H2REGEX = /\A=+\s*\z/
H3REGEX = /\A-+\s*\z/
H4REGEX = /\A\++\s*\z/
BLANKREGEX = /\A\s*\z/
TITLEREGEX = /[A-Za-z]+/
SECTIONCHARS = ['=', '-', '`', ':', '.', '\'', '"', '~', '^', '_', '*', '+', '#'].freeze

# Write new underline section adornment for a given title string
def adorn(str, adornmentChar, title)
  [MINADORNMENT, title.length].max.times do
    str.putc adornmentChar
  end
  str.print "\n"
end

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
# demote_headings
#
# This function transforms a chef-docs topic by demoting heading levels,
# converting H1 to H2, H2 to H3 and so on. This transformation
# allows multiple top-level doc topics to be assembled into all-in-one
# topics, such as runbook.html and resources.html.
#
# The function relies on conventions used by chef-docs. It does not
# handle generalized restructuredText, which has a more complicated
# annotation scheme for headings. Sections in rst are explained in
# http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#sections.
#
# Chef docs assume that:
#
# - H1 headings have overline *and* underline adornment using the "=" character.
#
# - Section headings other than H1 use underline adornment only.
#
# - H2 headings use the "=" character for their underline adornment.
#
# - H3 headings use the "-" character for their underline adornment.
#
# - H4 headings use the "+" character for their underline adornment.
#
# - H5 headings are not allowed in the input. However, when we convert
#   an H4 to an H5 in the output, we use the "^" character as adornment
#   in the output file.
#
# - Nesting is consecutve; for example, H3 can follow H2 but not H1
#
def demote_headings(id, instr, outstr)
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
      outstr.puts line
      h1Mode = 2 # enter H1 "expecting underline" mode

    # H1 underline
    elsif h1Mode == 2
      fail_at(id, lineNo, "expected H1 underline, saw #{line}") unless line.match(H1REGEX)
      adorn(outstr, H2CHAR, prevLine)   # Demote H1 to H2
      h1Mode = 0                        # exit H1 parsing mode

    # H2
    elsif line.match(H2REGEX)
      fail_at(id, lineNo, 'H2 seen without H1') if level < 1
      check_title(id, lineNo, prevLine)
      adorn(outstr, H3CHAR, prevLine) # Demote H2 to H3
      level = 2

    # H3
    elsif line.match(H3REGEX)
      fail_at(id, lineNo, 'H3 seen without H2') if level < 2
      check_title(id, lineNo, prevLine)
      adorn(outstr, H4CHAR, prevLine) # Demote H3 to H4
      level = 3

    # H4
    elsif line.match(H4REGEX)
      fail_at(id, lineNo, 'H4 seen without H3') if level < 3
      check_title(id, lineNo, prevLine)
      adorn(outstr, H5CHAR, prevLine) # Demote H4 to H5
      level = 4

    # all other lines
    else
      fail_at(id, lineNo, "unexpected section break #{line}") if is_section(line)
      outstr.puts line

    end

    lineNo += 1
    prevLine = line
  end
end

#
# create_allinone
#
# Builds an rst topic from an intro section and
# and array of subsections (with headings to be
# demoted).
#
def create_allinone(prologue, topics, outFileName)
  File.open(outFileName, 'w') do |outstr|
    File.open(prologue) do |file|
      outstr.write file.read
    end
    topics.each do |fileName|
      File.open(fileName) do |topic|
        outstr.print("\n")
        demote_headings(fileName, topic, outstr)
      end
    end
  end
end

# Note: missing multiple chef_*, ksh, launchd, load_balancer,
# multiple machine_*, private_key, public_key, yum_repository
# resource_examples

def lines_as_array(fileName)
  result = []
  File.open(fileName) do |lines|
    lines.each_line do |line|
      result << line.strip
    end
  end
  result
end

create_allinone(ARGV[0], lines_as_array(ARGV[1]), ARGV[2])
