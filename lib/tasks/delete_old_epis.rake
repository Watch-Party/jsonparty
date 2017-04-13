
desc 'Delete Episodes Before App Came Online'
task delete_old_epis: :environment do
   Episode.find_each do |epi|
     if epi.air_date <= ('Wed, 04 Aug 2016 21:17:26 UTC +00:00')
       epi.destroy
     end
   end
end
