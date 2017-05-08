class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  REQUIRED_COLUMN_HEADERS = ['HeadOfHousehold',
                             'EmailAddress',
                             'PhoneNumber',
                             'ActiveParticipants']
  has_many :children

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  def username
    self.first_name << ' ' << self.last_name
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    headers = spreadsheet.row(1)
    if (REQUIRED_COLUMN_HEADERS - headers).blank?
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[headers, spreadsheet.row(i)].transpose]
        name = row['HeadOfHousehold']
        first_name = name.split(',').last.strip
        last_name = name.split(',').first.strip
        user = where(first_name: first_name).first || new
        user.first_name = first_name
        user.last_name = last_name
        user.email = row['EmailAddress']
        user.phone = row['PhoneNumber'].gsub(/[-()  ext.]/, '')
        user.active_participants = row['ActiveParticipants']
        user.save!
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
