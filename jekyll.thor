require 'stringex'

# Taken from:
# http://jonas.brusman.se/2012/12/28/create-jekyll-posts-from-the-command-line/
class Jekyll < Thor
  desc 'new', 'create a new post'
  method_option :editor, default: 'atom'

  def new(*title)
    title = title.join('')
    date = Time.now.strftime('%Y-%m-%d')
    filename = "_posts/#{date}-#{title.to_url}.md"

    abort("#{filename} already exists!") if File.exist?(filename)

    create_post(filename, title)
    system(options[:editor], filename)
  end

  private

  def create_post(filename, title)
    puts "Creating new post: #{filename}"

    open(filename, 'w') do |post|
      post.puts '---'
      post.puts 'layout: post'
      post.puts "title: \"#{title.gsub(/&/, '&amp;')}\""
      post.puts '---'
    end
  end
end
