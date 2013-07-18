require 'spec_helper'

describe "LayoutLinks" do

  it "should have the right links on the layout" do
    visit root_path
    response.should have_title("Home")
    click_link "About"
    response.should have_title("About")
    click_link "Contact"
    response.should have_title("Contact")
    click_link "Home"
    response.should have_title("Home")
    click_link "Sign up now!"
    response.should have_title("Sign up")
  end

  #it "should have a homepage at '/'" do
    #get '/'
    #response.should have_title("Home")
  #end

  #it "should have a contact at '/contact'" do
    #get '/contact'
    #response.should have_title("Contact")
  #end
#
  #it "should have a contact at '/about'" do
    #get '/contact'
    #response.should have_title("About")
  #end
#
  #it "should have a contact at '/contact'" do
    #get '/contact'
    #response.should have_title("Help")
  #end

end
