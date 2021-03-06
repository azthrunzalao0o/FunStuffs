require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class MinerController < Rho::RhoController
  include BrowserHelper
  
  def index
    workerId = @params["workerId"]
    @worker = Miner.find(workerId)
    render
  end
  
end