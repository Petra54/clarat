class RemoveDependentCategories < ActiveRecord::Migration
  def change
    drop_table :dependent_categories

    # Offer.reindex! # I just didn't want to write a new migration for this ...
  end
end
