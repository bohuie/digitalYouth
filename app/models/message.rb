class Message  < ActiveRecord::Base

  attr_accessor :name, :email, :content
  validates :name, presence: true
  validates :email, presence: true
  validates :content, presence: true

end