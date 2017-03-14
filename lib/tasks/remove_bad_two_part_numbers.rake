
desc 'Delete episodes that got numbered stupidly'
task remove_bad_two_part_numbers: :environment do
 Episode.each do |epi|
   if epi.episode_number == '#{self.episode_number}.5'
     epi.destroy
   end
 end
 puts "bad episode destroyed"
end
