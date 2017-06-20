class AddHideToResourceLinks < ActiveRecord::Migration
  def change
    add_column :resource_links, :hide, :boolean
  end
end
