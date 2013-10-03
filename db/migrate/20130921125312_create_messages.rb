class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
        t.belongs_to    :user
        t.integer       :recipient_id
        t.string        :title
        t.string        :content
        t.attachment    :attachment
        t.boolean       :deleted
        t.boolean       :read

      t.timestamps
    end
  end
end
