_addon.name = 'Multictrl'
_addon.author = 'Kate'
_addon.version = '1.2.0.5'
_addon.commands = {'multi','mc'}

require('functions')
require('logger')
config = require('config')
packets = require('packets')
require('coroutine')

settings = config.load(defaults)

ipcflag = false
currentPC=windower.ffxi.get_player()

windower.register_event('addon command', function(input, ...)
    local cmd = string.lower(input)
	local args = {...}
	
	if cmd == 'on' then
		on()
	elseif cmd == 'off' then
		off()
	elseif cmd == 'fon' then
		followon()
	elseif cmd == 'foff' then
		followoff()
	elseif cmd == 'warp' then
		warp()
	elseif cmd == 'omen' then
		omen()
	elseif cmd == 'mount' then
		mount()
	elseif cmd == 'dismount' then
		dismount()
	elseif cmd == 'refresh' then
		refresh()
	elseif cmd == 'd2' then
		d2()
    end
end)


function refresh()

	log('Reloading addons')
	windower.send_command('lua r healbot')
	windower.send_command('gs enable all')
	if ipcflag == false then
		ipcflag = true
		windower.send_ipc_message('refresh')
	end
	ipcflag = false
end

function d2()

	for k, v in pairs(windower.ffxi.get_party()) do
		if type(v) == 'table' then
			if v.name ~= currentPC.name then
			
				ptymember = windower.ffxi.get_mob_by_name(v.name)
				-- check if party member in same zone.

				if v.mob == nil then
					-- Not in zone.
					log(v.name .. ' is not in zone, skipping')
					coroutine.sleep(0.5)
				else
					-- In zone, do distance check
					if math.sqrt(ptymember.distance) < 18 then
						log('Warping ' .. v.name)
						windower.send_command('input /ma "Warp II" ' .. v.name)
						coroutine.sleep(9)
					else
						log(v.name .. ' is too far to warp, skipping')
						coroutine.sleep(0.5)
					end
				end

			end
		end
	end
	windower.send_command('input /ma "Warp" ' .. currentPC.name)
end

function omen()

	log('Teleporting to Omen')
	windower.send_command('myomen')
	if ipcflag == false then
		ipcflag = true
		windower.send_ipc_message('omen')
	end
	ipcflag = false
end

function mount()

	log('Mounting Red Crab')
	windower.send_command('input /mount \'Red Crab\'')
	if ipcflag == false then
		ipcflag = true
		windower.send_ipc_message('mount')
	end
	ipcflag = false
end

function dismount()
	log('Dismounting.')
	windower.send_command('input /dismount')
	if ipcflag == false then
		ipcflag = true
		windower.send_ipc_message('dismount')
	end
	ipcflag = false
end

function warp()
	log('Warping!')
	windower.send_command('warp')
	if ipcflag == false then
		ipcflag = true
		windower.send_ipc_message('warp')
	end
	ipcflag = false
end

function on()
	log('Turning on addon stuff...')
	windower.send_command('hb on')
	windower.send_command('geo on')
	windower.send_command('roller on')
	windower.send_command('singer on')
	--windower.send_command('gs c toggle AutoTankMode')
	if ipcflag == false then
		ipcflag = true
		windower.send_ipc_message('on')
	end
	ipcflag = false
end

function off()
	log('Turning off addon stuff...')
	windower.send_command('hb off')
	windower.send_command('geo off')
	windower.send_command('roller off')
	windower.send_command('singer off')
	if ipcflag == false then
		ipcflag = true
		windower.send_ipc_message('off')
	end
	ipcflag = false
end

function followon(namearg)
	log('Follow ON')

	if ipcflag == false then
		--ipcflag = true
		windower.send_command('hb follow off')
		windower.send_ipc_message('followon ' .. currentPC.name)
	elseif ipcflag == true then
		windower.send_command('hb follow ' .. namearg)
	end
	ipcflag = false
	
end


function followoff()
	log('Follow OFF')
	windower.send_command('hb follow off')
	if ipcflag == false then
		ipcflag = true
		windower.send_ipc_message('followoff')
	end
	ipcflag = false
end



local function get_delay()
    local self = windower.ffxi.get_player().name
    local members = {}
    for k, v in pairs(windower.ffxi.get_party()) do
        if type(v) == 'table' then
            members[#members + 1] = v.name
        end
    end
    table.sort(members)
    for k, v in pairs(members) do
        if v == self then
            return (k - 1) * settings.send_all_delay
        end
    end
end


windower.register_event('ipc message', function(msg) 
	local args = msg:split(' ')
	local cmd = args[1]
	local cmd2 = args[2]
	args:remove(1)
	local delay = get_delay()
	
	if cmd == 'mount' then
		log('IPC Mount')
		coroutine.sleep(delay)
		ipcflag = true
		mount()
	elseif cmd == 'dismount' then
		log('IPC Dismount')
		coroutine.sleep(delay)
		ipcflag = true
		dismount()
	elseif cmd == 'warp' then
		log('IPC Warp')
		coroutine.sleep(delay)
		ipcflag = true
		warp()
	elseif cmd == 'on' then
		log('IPC Turn ON')
		coroutine.sleep(delay)
		ipcflag = true
		on()
	elseif cmd == 'off' then
		log('IPC Turn OFF')
		coroutine.sleep(delay)
		ipcflag = true
		off()
	elseif cmd == 'omen' then
		log('IPC Omen')
		coroutine.sleep(delay)
		ipcflag = true
		omen()
	elseif cmd == 'followoff' then
		log('IPC Follow OFF')
		coroutine.sleep(delay)
		ipcflag = true
		followoff()
	elseif cmd == 'followon' then
		log('IPC Follow ON')
		coroutine.sleep(delay)
		ipcflag = true
		followon(cmd2)
	elseif cmd == 'refresh' then
		log('IPC Refresh healbot')
		coroutine.sleep(delay)
		ipcflag = true
		refresh()
	end
	
end)