require 'uuidtools'
class User < ApplicationRecord
    validates :mail, uniqueness: true
    has_many :event,foreign_key: "uuid", primary_key: "uuid"
    before_create do
        self.uuid = UUIDTools::UUID.random_create.to_s
    end
end
