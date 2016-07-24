class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  belongs_to :author, class_name: 'User'
  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}
  scope :coming, -> { where("starts_at > ?", Date.today) }

  def self.search(keyword)
    where('name ILIKE ? OR extended_html_description ILIKE ?', "%#{keyword}%", "%#{keyword}%")
  end

  def mark_as_publish!
    self.publish = true
    self.save!
  end

  def is_owned?(user)
    self.author == user
  end

end
