json.array!(@boards) do |board|
  json.extract! board, :name, :description
  json.url board_url(board, format: :json)
end
