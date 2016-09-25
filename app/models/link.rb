class Link < ApplicationRecord
  validates :slug, presence: true
  validates :target_url, presence: true

  belongs_to :user
  has_many :visits

  def standardize_target_url!
    target_url.gsub!("http://", "")
    target_url.gsub!("https://", "")
  end
  
  def visit_count
    visits.count
  end
end
