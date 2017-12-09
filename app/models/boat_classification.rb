class BoatClassification < ActiveRecord::Base
  belongs_to :boat, counter_cache: :classifications_count
  belongs_to :classification
end
