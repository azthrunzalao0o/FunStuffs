require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'
require 'helpers/web_request_helper'

class SettingsController < Rho::RhoController
  include BrowserHelper
  include WebRequestHelper
  
  def setup
    resetAppInfo
    @error = @params["error"]
    render
  end
  
  def home
    @workers = Miner.find(:all)
    @panel = Settings.panelOverall
    render
  end
  
  def wait
    @mode = @params["mode"]
    case @mode
    when Settings::WAITFOR_SETUP then @msg = "Downloading Information"
    when Settings::WAITFOR_CONFIG then @msg = "Configure Miner Watcher"
    end
    render
  end
  
  def showLogs
    Rho::Log.showLog
  end

  def storePanelId
    panelId = @params["panelId"]
    Settings.set(Settings::PANELID, panelId)
    render :layout => false
  end
  
  def updateCriticalVal
    type = @params["criticalType"]
    value = @params["criticalVal"]
    Settings.set(type, value)
  end
  
  def resetAppInfo
    Miner.delete_all
    Settings.set(Settings::PANELID, "")
    Settings.set(Settings::PANELOVERALL, Hash.new.to_json)
  end
  
end
