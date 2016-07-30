json.upcoming @episodes do |epi|
  json.show   epi.show.title
  json.season         epi.season
  json.episode_number epi.episode_number
  json.episode_title  epi.title
  json.air_date       epi.air_date
end
