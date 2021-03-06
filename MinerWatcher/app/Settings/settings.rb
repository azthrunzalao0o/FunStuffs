require "helpers/application_helper"
require "json"

class Settings
  include Rhom::PropertyBag
  
  set :partition, :user
  
  PANELID = "panelId"
  PANELOVERALL = "panelOverall"
  
  CRITICALGPUHASH = "criticalGPUHash"
  CRITICALGPUTEMP = "criticalGPUTemp"
  CRITICALGPUWATT = "criticalGPUWatt"
  
  WAITFOR_SETUP = "setup"
  WAITFOR_CONFIG = "config"
  
  class << self
    include ApplicationHelper
    
    def instance
      resetInstance unless @instance
      @instance
    end
    
    def resetInstance
      @instance = Settings.find(0).first
      @instance = Settings.create({"object" => 0}) if @instance.nil? or @instance.empty?
    end
    
    def set(key, value)
      instance.update_attributes({key => value})
    end
    
    def panelId
      instance.panelId
    end
    
    def panelOverall
      if instance.panelOverall.nil?
        set(PANELOVERALL, Hash.new.to_json)
      end
      Rho::JSON.parse(instance.panelOverall)
    end
    
    def criticalGPUHash
      if instance.criticalGPUHash.nil?
        set(CRITICALGPUHASH, "25")
      end
      instance.criticalGPUHash
    end
    
    def criticalGPUTemp
      if instance.criticalGPUTemp.nil?
        set(CRITICALGPUTEMP, "70")
      end
      instance.criticalGPUTemp
    end
    
    def criticalGPUWatt
      if instance.criticalGPUWatt.nil?
        set(CRITICALGPUWATT, "150")
      end
      instance.criticalGPUWatt
    end
    
  end
end