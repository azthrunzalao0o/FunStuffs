# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class Miner
  include Rhom::PropertyBag

  set :partition, :user

  class << self
    
    def storeMinerStatus(data)
      Miner.delete_all
      db = ::Rho::RHO.get_src_db("Miner")
      db.start_transaction
      begin
        data.keys.each do |workerId|
          worker = data[workerId]
          Miner.create({
            "object" => workerId,
            "condition" => worker["condition"],
            "osVersion" => worker["version"],
            "driver" => worker["driver"],
            "miner" => worker["miner"],
            "numOfGPU" => worker["gpus"],
            "minerInstance" => worker["miner_instance"],
            "minerHashes" => worker["miner_hashes"],
            "bioses" => worker["bioses"],
            "gpusInfo" => worker["meminfo"],
            "gpusRam" => worker["vramsize"],
            "osDriver" => worker["drive_name"],
            "motherboard" => worker["mobo"],
            "biosVersion" => worker["biosversion"],
            "chipLAN" => worker["lan_chip"],
            "rigRam" => worker["ram"],
            "flags" => worker["flags"],
            "rackLoc" => worker["rack_loc"],
            "rigIpAddress" => worker["ip"],
            "serverTime" => worker["server_time"],
            "rigUpTime" => worker["uptime"],
            "minerUpTime" => worker["miner_secs"],
            "rx" => worker["rx_kbps"],
            "tx" => worker["tx_kbps"],
            "sysLoadAvg" => worker["load"],
            "cpuTemp" => worker["cpu_temp"],
            "freeRam" => worker["freespace"],
            "totalHash" => worker["hash"],
            "minePool" => worker["pool"],
            "gpuTemp" => worker["temp"],
            "gpuPTune" => worker["powertune"],
            "gpuVoltage" => worker["voltage"],
            "gpuWatt" => worker["watts"],
            "gpuFanRPM" => worker["fanrpm"],
            "gpuCore" => worker["core"],
            "gpuMem" => worker["mem"]
          })
        end
        db.commit
      rescue Rho::RhoError => e        
        db.rollback
      end
    end
    
    def getGPUBoxColor(index)
      colorCode = ""
      case index
      when 0 then colorCode = "94aea3"
      when 1 then colorCode = "a394ae"
      when 2 then colorCode = "aea394"
      when 3 then colorCode = "ecd28f"
      when 4 then colorCode = "8fecd2"
      when 5 then colorCode = "d28fec"
      end
      colorCode
    end
    
    def getUpTimeString(upTime)
      upTime = upTime.to_i
      days = 0
      hours = 0
      minutes = 0
      seconds = 0
      upTimeString = ""
      
      calDays = upTime / (60*60*24)
      if calDays > 0
        days = calDays
        upTime = upTime - (calDays * 60 * 60 *24)
      end
      calHours = upTime / (60 * 60)
      if calHours > 0
        hours = calHours
        upTime = upTime - (calHours * 60 * 60)
      end
      calMinutes = upTime / 60
      if calMinutes > 0
        minutes = calMinutes
        upTime = upTime - (calMinutes * 60)
      end
      seconds = upTime
      
      upTimeString = "#{days} Days, #{hours} Hrs, #{minutes} Mins, #{seconds} Secs"
      upTimeString
    end
    
  end
end
