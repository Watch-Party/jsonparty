json.results @results do |res|
  if res.searchable_type == "User"
    json.username  res.content.split.first
    json.email     res.content.split.last
  else
    json.showname   res.content
  end
  json.type   res.searchable_type
  json.id     res.searchable_id
end
