json.array! pages do |page|
  json.id page.id.to_s
  json.uid page.uid
  json.username page.username
end
