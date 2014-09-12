Sequel.migration do
  up do
    create_table :articles do
      primary_key :id
      Integer :article_id
      Integer :photographer_id
    end
  end

  down do
    drop_table :articles
  end
end
