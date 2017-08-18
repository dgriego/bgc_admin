# == Schema Information
#
# Table name: participants
#
#  id            :integer          not null, primary key
#  first_name    :string
#  age           :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  last_name     :string
#  member_number :integer
#

class Participant < ActiveRecord::Base
  has_many :participant_trips
  has_many :trips, through: :participant_trips

  has_many :participant_users
  has_many :users, through: :participant_users

  validates :first_name, presence: true
  validates :last_name, presence: true

  REQUIRED_COLUMN_HEADERS_FOR_IMPORT = [
    'FirstName',
    'LastName',
    'ParticipantNumber',
    'BirthDate'
  ]

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    headers = spreadsheet.row(1)
    if (REQUIRED_COLUMN_HEADERS_FOR_IMPORT - headers).blank?
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[headers, spreadsheet.row(i)].transpose]
        first_name = row['FirstName']
        participant = where(first_name: first_name).first || new
        participant.first_name = first_name
        participant.last_name = row['LastName']
        participant.member_number = row['ParticipantNumber']
        participant.age = calculate_age(row['BirthDate'])

        begin
          participant.save!
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

  def fullname
    self.first_name << ' ' << self.last_name
  end

  def guardian
    users.first
  end

  def primary_trip
    participant_trips.where(primary: true).collect(&:trip).first
  end

  def alternate_trip
    participant_trips.where(primary: false).collect(&:trip).first
  end

  private

  def self.calculate_age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
end
