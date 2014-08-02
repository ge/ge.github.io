#!/usr/bin/env ruby

require 'fileutils'

# I think I'm trying to make a version of newpost that can be run from outside the jekyll directory.  The reason is that files in the jekyll directory are copied to the server.  The key to the new version is the variable SRCDIR

DEBUG = false
#SRCDIR = %q{/Users/ge/Dropbox/ge/george.entenman.name.jekyll2/george.entenman.name}
SRCDIR = File.expand_path File.dirname(__FILE__)
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
	postname = ARGV[0].gsub(" ","-").gsub(",","").downcase
  

	#categories = %q{TBD}
	categories = ARGV[1..-1]
	main_category = ARGV[1] || %q{TBD}

	postfilename = %Q{#{postdate}-#{postname}.md}

	postbasesubpath = %Q{/#{main_category}/#{postdate}-#{postname}}
	postsubpath = %Q{#{postbasesubpath}.md}
	permalink = %Q{#{postbasesubpath}.html}

	assetsbasesubpath = %Q{assets/#{main_category}/#{postdate}-#{postname}}
	assetsfullpathname = %Q{#{SRCDIR}/#{assetsbasesubpath}}

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

![Sample Image Link](#{assetsbasesubpath}/FOO.jpg)

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

	assetsbasesubpath: #{assetsbasesubpath}
	assetsfullpathname: #{assetsfullpathname}

Creating assets directory: #{assetsbasesubpath}
Creating post file [#{postfullpathname}]
Contents of the file:
#{initialfilecontents}
EOF

if DEBUG
	STDERR.puts debug_message
else
  begin
    File.open(postfullpathname,'w') do |f|
      f.puts %Q{#{initialfilecontents}}
    end
    STDERR.puts %Q{Have created post: #{postrelpathname}}
	FileUtils.mkdir_p(assetsfullpathname)
    STDERR.puts %Q{Have created a directory for photos: #{assetsbasesubpath}}
	
  rescue Exception => e  
    STDERR.puts "There was an error: #{e.message}"  
    raise
  end
end


__END__

