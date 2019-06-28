class AdminEvent < ApplicationRecord
    has_rich_text :content
    has_one_attached :image
    validates :count, presence: true
    validates :title, presence: true
end
