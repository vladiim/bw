Sequel.migration do
  up do
    create_table :hero_images do
      primary_key :id
      Integer :article_id
      Integer :image_id
    end
  end

  down do
    drop_table :hero_images
  end
end
