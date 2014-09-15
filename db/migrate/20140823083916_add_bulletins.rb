class AddBulletins < ActiveRecord::Migration
  BULLETINS = %w(공지사항 새소식 가입인사 갤러리)

  def up 
    BULLETINS.each do |bulletin|
      Bulletin.find_or_create_by(title: bulletin)
    end

    BULLETINS.each_with_index do |bulletin, index|
      bulletin = Bulletin.find_by(title: bulletin)
      post_type = %w(blog news greeting gallery)[index]
      bulletin.update!(post_type: post_type)
    end
  end

end
