class CreateJoinTableProfileBrand < ActiveRecord::Migration
  def change
    create_join_table :profiles, :brands do |t|
      # t.index [:profile_id, :brand_id]
      # t.index [:brand_id, :profile_id]
    end
  end
end
