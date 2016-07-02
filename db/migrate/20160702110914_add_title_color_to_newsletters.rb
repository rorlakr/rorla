class AddTitleColorToNewsletters < ActiveRecord::Migration
  def change
    add_column :newsletters, :title_color, :string
  end
end
