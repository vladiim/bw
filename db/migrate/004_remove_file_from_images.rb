Sequel.migration do
  up do
    alter_table :images do
      add_column :url, String
      drop_column :file_name
      drop_column :file
    end
  end

  down do
    alter_table :images do
      drop_column :url
      add_column :file_name, String
      add_column :file, String
    end
  end
end
