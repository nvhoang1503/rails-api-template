class CreateExamples < ActiveRecord::Migration[5.0]

  def up
    create_table :examples do |t|
      t.string :photo
      t.timestamps
    end
    Example.create_translation_table! :name => :string, :content => :text
  end
  def down
    drop_table :examples
    Example.drop_translation_table!
  end


end
