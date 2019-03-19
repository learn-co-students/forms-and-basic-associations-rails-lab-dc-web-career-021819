class Genre < ActiveRecord::Base
  # add associations
  has_many :artists
  has_many :songs
end
