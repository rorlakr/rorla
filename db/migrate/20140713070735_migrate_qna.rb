class MigrateQna < ActiveRecord::Migration
  def up
    user = User.first
    Question.all.each do |question|
      question.user ||= user
      question.save!
    end

    Answer.all.each do |answer|
      answer.user ||= user
      answer.save!
    end
  end
end
