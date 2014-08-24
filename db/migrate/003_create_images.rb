Sequel.migration do
  up do
    create_table :images do
      primary_key :id
      String :title
      Text :file
      String :file_name
      Integer :photographer_id
    end
  end

  down do
    drop_table :images
  end
end
