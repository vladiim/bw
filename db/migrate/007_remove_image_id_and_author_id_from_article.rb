Sequel.migration do
  up do
    alter_table :articles do
      drop_column :image_id
      drop_column :author_id
    end
  end

  down do
    alter_table :articles do
      add_column :image_id, Integer
      add_column :author_id, Integer
    end
  end
end
