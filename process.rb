def get_filepath(query)
  space_tilde_slash = /^\s*~\//
  if query.start_with?(space_tilde_slash)
    username = `whoami`.strip
    subpath = query.sub(space_tilde_slash, '')
    "/Users/#{username}/#{subpath}"
  else
    query.gsub(/^\s*/, '')
  end
end

def get_script(query)
  filepath = get_filepath(query)
  if File.directory?(filepath)
    "cd \"#{filepath}\""
  else
    # Remove the single dollar sign in the beginning of each line.
    query.gsub(/^\s*\$\s+/, '')
  end
end

filepath = ARGV[0]
file_contents = File.read(filepath)
File.write(filepath, get_script(file_contents))
