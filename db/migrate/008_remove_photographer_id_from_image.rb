Sequel.migration do
  up do
    alter_table :images do
      drop_column :photographer_id
    end
  end

  down do
    alter_table :images do
      add_column :photographer_id, Integer
    end
  end
end
