#!/usr/bin/env ruby

DEBUG = false
POSTSDIR = %q{/Users/ge/Dropbox/ge/george.entenman.name/_posts}

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
	postpathname = %Q{#{POSTSDIR}/#{main_category}/#{postdate}-#{postname}.md}

	permalink = %Q{/#{main_category}/#{postdate}-#{postname}.html}

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

	postfilename: #{postfilename}
	POSTSDIR: #{POSTSDIR}
	postpathname: #{postpathname}

Creating post file [#{postpathname}]
Contents of the file:
#{initialfilecontents}
EOF

if DEBUG
	STDERR.puts debug_message
else
  File.open(postpathname,'w') do |f|
  	f.puts %Q{#{initialfilecontents}}
  end
  STDERR.puts %Q{Have created _posts/#{postpathname}}
end


__END__
