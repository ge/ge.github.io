#!/usr/bin/env ruby

DEBUG = true
SRCDIR = %q{/Users/ge/Dropbox/ge/george.entenman.name}
POSTSDIR = %Q{#{SRCDIR}/_posts}

unless ARGV[1]
  puts 'Usage: newpost "the post title" category {subcategory*}'
  exit(-1)
end
 
# computed values
	postdate = Time.now.strftime("%Y-%m-%d")
	posttimestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")

	# posttitle = ARGV.join(" ")
	posttitle = ARGV[0]
	postname = ARGV[0].gsub(" ","-").downcase
  

	#categories = %q{TBD}
	categories = ARGV[1..-1]
	main_category = ARGV[1] || %q{TBD}

	postfilename = %Q{#{postdate}-#{postname}.md}

	postbasesubpath = %Q{/#{main_category}/#{postdate}-#{postname}}
	postsubpath = %Q{#{postbasesubpath}.md}
	permalink = %Q{#{postbasesubpath}.html}

	postrelpathname = %Q{_posts#{postsubpath}}
	postfullpathname = %Q{#{SRCDIR}/#{postrelpathname}}


initialfilecontents = <<-EOF
---
layout: post
title: #{posttitle}
date: #{posttimestamp}
categories: #{categories}
permalink: #{permalink}
---

<!-- EXCERPT HERE -->

<!--more-->

## Highest-Level Header in this file.

EOF

debug_message = <<-EOF
	postdate: #{postdate}
	posttimestamp: #{posttimestamp}

	post title:  #{posttitle}

	SRCDIR: #{SRCDIR}
	POSTSDIR: #{POSTSDIR}

	postfilename: #{postfilename}

	postbasesubpath: #{postbasesubpath}
	postsubpath: #{postsubpath}
	permalink: #{permalink}

	postrelpathname: #{postrelpathname}
	postfullpathname: #{postfullpathname}


Creating post file [#{postfullpathname}]
Contents of the file:
#{initialfilecontents}
EOF

if DEBUG
	STDERR.puts debug_message
else
  File.open(postfullpathname,'w') do |f|
  	f.puts %Q{#{initialfilecontents}}
  end
  STDERR.puts %Q{Have created #{postrelpathname}}
end


__END__
