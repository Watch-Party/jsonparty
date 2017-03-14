
desc 'Check for new episodes, add if found'
task update_episodes: :environment do
   Show.find_each do |show|
     if show.confirmed == true
       resp = HTTParty.get "http://api.tvmaze.com/shows/#{show.tvrage_id}/episodes"
       unless resp.count == show.episodes.count
         puts "#{show.title} updating"
         ei = EpisodeIndexer.new(show)
         ei.update
         puts "#{show.title} updated"
       end
     end
   end
end
