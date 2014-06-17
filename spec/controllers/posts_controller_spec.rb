require 'spec_helper'

describe PostsController do

  before :each do
    @current_user = User.create!                      \
                         email:"admin@rorlab.org",    \
                         password:"12345678",         \
                         confirmed_at: Time.now
    @bulletin = create(:bulletin)
  end

  let(:bulletin_post_create) { create(:bulletin_post, bulletin: @bulletin, writer: @current_user) }
  let(:valid_attributes) { attributes_for(:bulletin_post, bulletin: @bulletin) }
  let(:invalid_attributes) { attributes_for(:post, title: nil, content: nil) }
  let(:valid_session) do
    @current_user.confirm!
    sign_in @current_user
  end

  describe 'GET #index' do
    it "> 모든 Post로 instance 변수를 할당한다." do
      posts = [bulletin_post_create, create(:bulletin_post, bulletin: @bulletin)]
      get :index, { bulletin_id: @bulletin }, valid_session
      expect(assigns(:posts)).to match_array(posts)
    end
  end

  describe 'GET #show' do
    it "> 요청한 Post로 instance 변수를 할당한다." do
      post = bulletin_post_create
      get :show, {bulletin_id: @bulletin, id: post}, valid_session
      expect(assigns(:post)).to eq bulletin_post_create
    end
  end

  describe 'POST #create' do
    context "1) params가 유효할 때" do
      it "> 새로운 Post를 생성한다." do
        expect {
          post :create, { bulletin_id: @bulletin, post: valid_attributes }, valid_session
        }.to change(Post, :count).by(1)
      end

      it "> 새로운 Post로 instance 변수를 할당한다." do
        post :create, {bulletin_id: @bulletin, post: valid_attributes}, valid_session
        expect(assigns(:post)).to be_a(Post)
        expect(assigns(:post)).to_not be_new_record
      end
    end

    context "2) params가 유효하지 않을 때" do
      it "> 새로운 Post를 생성하지 않는다." do
        expect {
          post :create, { bulletin_id: @bulletin, post: invalid_attributes}, valid_session
        }.to_not change(Post, :count)
      end

      it "> 새로운 Post를 instance 변수에 할당한다." do
        post :create, {bulletin_id: @bulletin, post: invalid_attributes}, valid_session
        expect(assigns(:post)).to be_a(Post)
        expect(assigns(:post)).to be_new_record
      end
    end
  end

  describe 'PATCH #update' do
    context "1) params가 유효할 때" do
      it "> 요청한 post를 업데이트한다." do
        patch :update, { bulletin_id: @bulletin, id: bulletin_post_create, post: attributes_for(:bulletin_post, title: "Wonderfulday isn't it?", content: "Yes!!!") }, valid_session
        bulletin_post_create.reload
        expect(bulletin_post_create.title).to eq("Wonderfulday isn't it?")
        expect(bulletin_post_create.content).to eq("Yes!!!")
      end

      it "> 요청한 post를 instance 변수에 할당한다." do
        patch :update, {bulletin_id: @bulletin, id: bulletin_post_create, post: valid_attributes}, valid_session
        bulletin_post_create.reload
        expect(assigns(:post)).to eq bulletin_post_create
      end
    end

    context "2) params가 유효하지 않을 때" do
      it "> 요청한 post를 업데이트하지 않는다." do
        patch :update, {bulletin_id: @bulletin, id: bulletin_post_create, post: invalid_attributes}, valid_session
        bulletin_post_create.reload
        expect(bulletin_post_create.title).to eq("post title")
        expect(bulletin_post_create.content).to eq("post content")
      end

      it "> 요청한 post를 instance 변수에 할당한다." do
        patch :update, {bulletin_id: @bulletin, id: bulletin_post_create, post: invalid_attributes}, valid_session
        bulletin_post_create.reload
        expect(assigns(:post)).to eq bulletin_post_create
      end
    end
  end

  describe 'DELETE #destroy' do
    it "> 요청한 post를 삭제한다." do
      bulletin_post_create
      expect {
        delete :destroy, {bulletin_id: @bulletin, id: bulletin_post_create}, valid_session
      }.to change(Post, :count).by(-1)
    end
  end

end
