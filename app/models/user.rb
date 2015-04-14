class User < ActiveRecord::Base
  has_attached_file :avatar, styles: lambda { |attachment| User.paperclip_styles } 
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  @@has_thumb = true

  def self.create_dummy_user!(index = 1) 
    User.create! name: "Foo#{index}",
                 phone_number: index.to_s,
                 avatar: File.new("#{Rails.root}/app/assets/images/hex01.gif")  
  end 

  def self.create_one_hundred_dummy_users!
    100.times do |index| 
      self.create_dummy_user!(index) 
    end
  end

  def self.create_five_hundred_dummy_users!
    500.times do |index| 
      self.create_dummy_user!(index) 
    end 
  end

  def self.has_thumb?
    @@has_thumb
  end

  def self.has_thumb=(arg = false) 
    @@has_thumb = arg
  end

  def self.paperclip_styles
    self.has_thumb? ? { thumb: '100x100>' } : {}
  end
end
