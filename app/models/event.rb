class Event < ApplicationRecord
    has_many :user,foreign_key: "uuid", primary_key: "uuid"
end
