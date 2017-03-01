
desc 'Check if a live feed exists for an episode, if not add'
task create_feeds_for_episodes_without: :environment do
  Episode.find_each do |epi|
    unless epi.feeds.where(name: 'live').present?
      epi.feeds.create!(species: "live",
                        start_time: epi.air_date,
                        name: "live"
                        )
      puts "live feed created for #{epi.show.title}:#{epi.title}"
    end
  end
end
