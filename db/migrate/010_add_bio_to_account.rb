Sequel.migration do
  up do
    alter_table :accounts do
      add_column :bio, 'TEXT'
    end
  end

  down do
    alter_table :accounts do
      drop_column :bio
    end
  end
end
