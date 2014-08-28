Sequel.migration do
  up do
    alter_table :images do
      add_column :created_at, DateTime
    end
  end

  down do
    alter_table :images do
      drop_column :created_at
    end
  end
end
