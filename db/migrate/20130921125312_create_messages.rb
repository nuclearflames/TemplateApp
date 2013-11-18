class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
        t.belongs_to    :user
        t.integer       :recipient_id
        t.string        :title
        t.string        :content
        t.attachment    :attachment
        t.boolean       :deleted, :default  => false
        t.boolean       :read, :default  => false

      t.timestamps
    end
  end
end
