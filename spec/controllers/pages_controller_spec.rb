require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    integrate_views
    it "returns http success" do
      get 'home'
      response.should be_success
    end
    #it "should have the right title" do
      #get 'home'
      #response.should have_css("title", :content => "Home")
    #end
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
  end
end
