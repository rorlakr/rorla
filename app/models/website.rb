require 'csv'

class Website < ActiveRecord::Base

  # Rolify and Authroization
  resourcify
  include Authority::Abilities

  as_enum :service_state, %i{on off}
  as_enum :service_type, %i{rails rails_api ruby}

  belongs_to :user

  validates :name, :site_url, presence: {message: "웹사이트명을 입력하세요."}
  validates :site_url, url: {:message => "URL형식에 오류가 있습니다."}

  def self.import(file)
    CSV.foreach(file, headers: true, :col_sep => ', ') do |row|
      puts row['name']
      puts row['site_url']
      puts row['service_type_1']
      puts row['service_type_2']
      puts row['service_state']
      puts row['memo']

      service_type = row['service_type_1']
      if row['service_type_2'] == 'backend'
        service_type = 'rails_api'
        memo = row['memo']
      end
      # puts service_type
      # puts row['service_type_2']
      service_state = row['service_state'] == 'ing' ? "on" : "off"
      Website.create! name: row['name'], site_url: row['site_url'], service_state: service_state, service_type: service_type, memo: memo,
      user: User.first
    end
  end

end
