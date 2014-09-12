Sequel.migration do
  up do
    create_table :photographers do
      primary_key :id
      String :website
      Integer :image_id
      Integer :account_id
    end
  end

  down do
    drop_table :photographers
  end
end
