require 'spec_helper'

require 'capybara'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'sinatra'

Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist
Capybara.save_path = File.dirname(__FILE__) + '/../tmp'

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
    expect(page).to have_content "Fort of javascript"
    expect(page).to have_content "Hello, world!"
    expect(page).to have_content "20"
    expect(page).to have_content "2014-04-23"
  end
end
