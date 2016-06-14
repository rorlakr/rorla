require 'csv'
desc "RailsTutorial 용어집 CSV 파일을 glossaries 와 glossary_definitions 테이블로 추가한다."
task :import_glossary, [:filename, :user_email] => [:environment] do |t, args|
    user = User.find_by_email(args[:user_email])
    if user.present?
      CSV.foreach( args[:filename], :headers => true) do |row|
        begin
          glossary = Glossary.create!(term: row[0], user: user, memo: row[2] )
          glossary.glossary_definitions.create!( definition: row[1], user: user )
        rescue ActiveRecord::RecordInvalid => invalid
          puts "#{row[0]} : #{invalid.record.errors.full_messages.join(', ')}"
        end
      end
    else
      puts "Email not registered!"
      puts "Usage: bin/rake \"import_glossary[filename, email]\""
    end
end
