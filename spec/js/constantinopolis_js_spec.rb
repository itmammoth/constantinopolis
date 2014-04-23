require 'spec_helper'

require 'capybara'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'sinatra'

Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist
Capybara.save_and_open_page_path = File.dirname(__FILE__) + '/../tmp'

class SettingRack < Constantinopolis::Fort
  yml File.expand_path('../setting_rack.yml', __FILE__)
end
SettingRack.build!

get '/' do
  file = open("spec/js/test.html.erb").read
  erb file
end

describe 'the dummy app', js: true do
  include Capybara::DSL

  before do
    Capybara.app = Sinatra::Application.new
  end

  it "renders javascript objects" do
    visit "/"
    page.should have_content "Fort of javascript"
    page.should have_content "Hello, world!"
    page.should have_content "20"
    page.should have_content "2014-04-23"
  end
end