json.upcoming @episodes do |epi|
  json.id             epi.id
  json.show           epi.show.title
  json.season         epi.season
  json.episode_number epi.episode_number
  json.episode_title  epi.title
  json.air_date       epi.air_date
end

json.currently_live @current do |cur|
  json.id             cur.id
  json.show           cur.show.title
  json.season         cur.season
  json.episode_number cur.episode_number
  json.episode_title  cur.title
  json.air_date       cur.air_date
end
