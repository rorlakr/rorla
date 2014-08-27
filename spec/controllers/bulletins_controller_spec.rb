require 'spec_helper'

describe BulletinsController do

  before :each do
    @current_user = User.create!                      \
                         email:"admin@rorlab.org",    \
                         password:"12345678",         \
                         confirmed_at: Time.now
  end

  let(:valid_attributes) { { title: "test" } }

  let(:valid_session) do
    @current_user.confirm!
    sign_in @current_user
  end

  describe "GET index" do
    it "assigns all bulletins as @bulletins" do
      Bulletin.delete_all

      bulletin = Bulletin.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:bulletins)).to match_array([bulletin])
    end
  end

  describe "GET show" do
    it "assigns the requested bulletin as @bulletin" do
      bulletin = Bulletin.create! valid_attributes
      get :show, {:id => bulletin.to_param}, valid_session
      assigns(:bulletin).should eq(bulletin)
    end
  end

  describe "GET new" do
    it "assigns a new bulletin as @bulletin" do
      get :new, {}, valid_session
      assigns(:bulletin).should be_a_new(Bulletin)
    end
  end

  describe "GET edit" do
    it "assigns the requested bulletin as @bulletin" do
      bulletin = Bulletin.create! valid_attributes
      get :edit, {:id => bulletin.to_param}, valid_session
      assigns(:bulletin).should eq(bulletin)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Bulletin" do
        expect {
          post :create, {:bulletin => valid_attributes}, valid_session
        }.to change(Bulletin, :count).by(1)
      end

      it "assigns a newly created bulletin as @bulletin" do
        post :create, {:bulletin => valid_attributes}, valid_session
        assigns(:bulletin).should be_a(Bulletin)
        assigns(:bulletin).should be_persisted
      end

      it "redirects to the created bulletin" do
        post :create, {:bulletin => valid_attributes}, valid_session
        response.should redirect_to(Bulletin.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved bulletin as @bulletin" do
        # Trigger the behavior that occurs when invalid params are submitted
        Bulletin.any_instance.stub(:save).and_return(false)
        post :create, {:bulletin => valid_attributes }, valid_session
        assigns(:bulletin).should be_a_new(Bulletin)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Bulletin.any_instance.stub(:save).and_return(false)
        post :create, {:bulletin => valid_attributes }, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested bulletin" do
        bulletin = Bulletin.create! valid_attributes
        Bulletin.any_instance.should_receive(:update).with({ "title" => "params" })
        put :update, {:id => bulletin.to_param, :bulletin => { "title" => "params" }}, valid_session
      end

  #     it "assigns the requested bulletin as @bulletin" do
  #       bulletin = Bulletin.create! valid_attributes
  #       put :update, {:id => bulletin.to_param, :bulletin => valid_attributes}, valid_session
  #       assigns(:bulletin).should eq(bulletin)
  #     end

  #     it "redirects to the bulletin" do
  #       bulletin = Bulletin.create! valid_attributes
  #       put :update, {:id => bulletin.to_param, :bulletin => valid_attributes}, valid_session
  #       response.should redirect_to(bulletin)
  #     end
    end

  #   describe "with invalid params" do
  #     it "assigns the bulletin as @bulletin" do
  #       bulletin = Bulletin.create! valid_attributes
  #       Bulletin.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => bulletin.to_param, :bulletin => {  }}, valid_session
  #       assigns(:bulletin).should eq(bulletin)
  #     end

  #     it "re-renders the 'edit' template" do
  #       bulletin = Bulletin.create! valid_attributes
  #       Bulletin.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => bulletin.to_param, :bulletin => {  }}, valid_session
  #       response.should render_template("edit")
  #     end
  #   end
  end

  # describe "DELETE destroy" do
  #   it "destroys the requested bulletin" do
  #     bulletin = Bulletin.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => bulletin.to_param}, valid_session
  #     }.to change(Bulletin, :count).by(-1)
  #   end

  #   it "redirects to the bulletins list" do
  #     bulletin = Bulletin.create! valid_attributes
  #     delete :destroy, {:id => bulletin.to_param}, valid_session
  #     response.should redirect_to(bulletins_url)
  #   end
  # end

end
