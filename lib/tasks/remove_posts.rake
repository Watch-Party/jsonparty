
desc 'Delete posts for shows that no longer exist'
task remove_posts: :environment do
  posts = 0
   Post.find_each do |post|
     if post.show.nil?
       if post.destroy
         posts += 1
       end
     end
   end
   puts "#{posts} posts destroyed"
end
