json.array!(@courses) do |course|
  json.extract! course, :id, :title, :description, :teacher, :end_date
  json.url course_url(course, format: :json)
end
