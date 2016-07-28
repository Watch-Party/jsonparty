
desc 'Update number of seasons'
task update_seasons: :environment do
   Show.find_each do |show|
     if show.confirmed == true
       sfinder = SeasonsFinder.new show
       show.seasons = sfinder.seasons
       if show.save
         puts "#{show.title} updated"
       end
     end
   end
end
