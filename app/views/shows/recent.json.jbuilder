json.recent_shows @shows do |show|
  json.title      show.title
  json.seasons (1..show.seasons) do |season|
    json.season     season
    json.episodes   show.episodes.where(season: season) do |episode|
      json.episode   episode.episode_number
    end
  end
end
