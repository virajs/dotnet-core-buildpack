$: << 'cf_spec'
require 'spec_helper'

describe 'CF Asp.Net5 Buildpack' do
  subject(:app) { Machete.deploy_app(app_name) }
  let(:browser) { Machete::Browser.new(app) }

  after do
    Machete::CF::DeleteApp.new.execute(app)
  end

  context 'deploy visual studio solution' do
    let(:app_name) { 'visual_studio_application' }

    it 'responds to http' do
      expect(app).to be_running
      expect(app).to have_logged /ASP.NET 5 buildpack version: 0.7.0/

      browser.visit_path('/')
      expect(browser).to have_body('ASP.NET')
      expect(browser).to have_body('Starter Application')
    end
  end
end
