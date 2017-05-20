# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  phone                  :string
#  email                  :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  last_name              :string
#  active_participants    :integer
#  admin                  :boolean          default("false")
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  active                 :boolean          default("true")
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :registerable,
         :rememberable, :trackable, :validatable

  REQUIRED_COLUMN_HEADERS_FOR_IMPORT = ['HeadOfHousehold',
                                        'EmailAddress',
                                        'PhoneNumber',
                                        'ActiveParticipants']

  has_many :participant_users
  has_many :participants, through: :participant_users

  validates_presence_of :email

  def self.guardians
    self.where(admin: false)
  end

  def self.admin
    self.where(admin: true)
  end

  def fullname
    self.first_name << ' ' << self.last_name
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    headers = spreadsheet.row(1)
    if (REQUIRED_COLUMN_HEADERS_FOR_IMPORT - headers).blank?
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[headers, spreadsheet.row(i)].transpose]
        name = row['HeadOfHousehold']
        first_name = name.split(',').last.strip
        last_name = name.split(',').first.strip
        user = where(first_name: first_name).first || new
        user.first_name = first_name
        user.last_name = last_name
        user.password = Devise.friendly_token.first(8)
        user.email = row['EmailAddress']
        user.phone = row['PhoneNumber'].to_s.gsub(/[-()  ext.]/, '')
        user.active_participants = row['ActiveParticipants']
        begin
          if user.save!
            Devise::Mailer.reset_password_instructions(user, user.password)
                          .deliver!
          end
        rescue
          next
        end
      end
    else
      raise 'You are missing some of the required headers, ' \
            'please double check your file and try again.'
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
