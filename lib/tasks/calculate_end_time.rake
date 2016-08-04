
desc 'calculate and update end time for episodes'
task calculate_end_time: :environment do
   Episode.find_each do |episode|
     episode.end_time = episode.air_date + episode.runtime.minutes
     episode.save
     puts "#{episode.title} updated"
   end
end
