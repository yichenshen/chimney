json.array!(@errands) do |errand|
  json.extract! errand, :id, :title, :content
  json.url errand_url(errand, format: :json)
end
