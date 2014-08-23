Sequel.migration do
  up do
    create_table :articles do
      primary_key :id
      String :title
      Integer :image_id
      Integer :author_id
      Text :body
      DateTime :created_at
      DateTime :published_at
    end
  end

  down do
    drop_table :articles
  end
end
