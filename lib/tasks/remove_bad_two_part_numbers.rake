
desc 'Delete episodes that got numbered stupidly'
task remove_bad_two_part_numbers: :environment do
  Episode.where(episode_number: '#{self.episode_number}.5').each do |epi|
    epi.destroy
  end
  puts "bad episode destroyed"
end
