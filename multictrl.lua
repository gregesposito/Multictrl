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
	elseif cmd == 'loadquetz' then
		loadquetz()
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
    end
end)


function refresh()

	log('Reloading addons')
	windower.send_command('lua r healbot')
	if ipcflag == false then
		ipcflag = true
		windower.send_ipc_message('refresh')
	end
	ipcflag = false
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

function loadquetz(namearg)
	log('Set addon commands for Quetz farming.')
	currentPC=windower.ffxi.get_player()
	-- Here change whatever commands you want your addons to use.
	
	-- If IPC false means your party leader commands, no assist.
	if ipcflag == false then

		-- Common commands
		windower.send_command('lua r healbot')
		coroutine.sleep(1.0)
		
		if currentPC.main_job == 'PLD' then
			windower.send_command('gs disable main')
			windower.send_command('/equip main \'Naegling\'')
			windower.send_command('hb mincure 4')
			windower.send_command('autows use savage blade')
			windower.send_command('autows hp > 0 < 99')
			windower.send_command('autows on')
		elseif currentPC.main_job == 'WAR' then
			windower.send_command('hb buff ' .. currentPC.name .. ' berserk')
			windower.send_command('hb buff ' .. currentPC.name .. ' hasso')
			windower.send_command('hb buff ' .. currentPC.name .. ' retaliation')
			windower.send_command('hb buff ' .. currentPC.name .. ' restraint')
			windower.send_command('hb buff ' .. currentPC.name .. ' blood rage')
			windower.send_command('autows use impulse drive')
			windower.send_command('autows hp > 0 < 99')
			windower.send_command('autows on')
		elseif currentPC.main_job == 'WHM' then
			windower.send_command('hb bufflist whm ' .. currentPC.name .. '')
			windower.send_command('hb buff ' .. currentPC.name .. ' auspice')
			windower.send_command('hb buff ' .. currentPC.name .. ' boost-dex')
			windower.send_command('gs disable main')
			windower.send_command('gs disable sub')
			windower.send_command('input /equip main \'Nibiru Cudgel\'; wait 1.0; input /equip sub \'Bolelabunga\'')
			-- WHM buffs haste on party

			for k, v in pairs(windower.ffxi.get_party()) do
				if type(v) == 'table' then
					if v.name ~= currentPC.name then
						windower.send_command('hb buff ' .. v.name .. ' haste')
					end
				end
			end
			
			windower.send_command('autows use hexa strike')
			windower.send_command('autows hp > 0 < 99')
			windower.send_command('autows on')
		elseif currentPC.main_job == 'GEO' then
			windower.send_command('geo geo frailty')
			windower.send_command('geo indi haste')
			windower.send_command('geo entrust off')
			windower.send_command('hb buff ' .. currentPC.name .. ' haste')
			windower.send_command('hb mincure 4')
			windower.send_command('hb debuff dia ii')
			windower.send_command('autows use hexa strike')
			windower.send_command('autows hp > 0 < 99')
			windower.send_command('autows on')
		elseif currentPC.main_job == 'COR' then
			windower.send_command('roller roll1 chaos')
			windower.send_command('roller roll2 rogue')
			windower.send_command('autows use evisceration')
			windower.send_command('autows hp > 0 < 99')
			windower.send_command('autows on')
		end
		windower.send_ipc_message('loadquetz ' .. currentPC.name)
		
	--
	-- Commands here for alts that aren't party leaders.
	--
	elseif ipcflag == true then
	
		-- Common commands
		windower.send_command('lua r healbot')
		coroutine.sleep(1.0)
		windower.send_command('hb assist ' .. namearg .. '')
		windower.send_command('hb assist attack')
		windower.send_command('hb follow ' .. namearg .. '')
		windower.send_command('hb follow dist 4')
		
		if currentPC.main_job == 'PLD' then
			windower.send_command('gs disable main')
			windower.send_command('/equip main \'Naegling\'')
			windower.send_command('hb mincure 4')
			windower.send_command('autows use savage blade')
			windower.send_command('autows hp > 0 < 99')
			windower.send_command('autows on')
		elseif currentPC.main_job == 'WAR' then
			windower.send_command('hb buff ' .. currentPC.name .. ' berserk')
			windower.send_command('hb buff ' .. currentPC.name .. ' hasso')
			windower.send_command('hb buff ' .. currentPC.name .. ' retaliation')
			windower.send_command('hb buff ' .. currentPC.name .. ' restraint')
			windower.send_command('hb buff ' .. currentPC.name .. ' blood rage')
			windower.send_command('autows use impulse drive')
			windower.send_command('autows hp > 0 < 99')
			windower.send_command('autows on')
		elseif currentPC.main_job == 'WHM' then
			windower.send_command('hb bufflist whm ' .. currentPC.name .. '')
			windower.send_command('hb buff ' .. currentPC.name .. ' auspice')
			windower.send_command('hb buff ' .. currentPC.name .. ' boost-dex')
			windower.send_command('gs disable main')
			windower.send_command('gs disable sub')
			windower.send_command('input /equip main \'Nibiru Cudgel\'; wait 1.0; input /equip sub \'Bolelabunga\'')
			-- WHM buffs haste on party

			for k, v in pairs(windower.ffxi.get_party()) do
				if type(v) == 'table' then
					if v.name ~= currentPC.name then
						windower.send_command('hb buff ' .. v.name .. ' haste')
					end
				end
			end
			
			windower.send_command('autows use hexa strike')
			windower.send_command('autows hp > 0 < 99')
			windower.send_command('autows on')
		elseif currentPC.main_job == 'GEO' then
			windower.send_command('geo geo frailty')
			windower.send_command('geo indi haste')
			windower.send_command('geo entrust off')
			windower.send_command('hb buff ' .. currentPC.name .. ' haste')
			windower.send_command('hb mincure 4')
			windower.send_command('hb debuff dia ii')
			windower.send_command('autows use hexa strike')
			windower.send_command('autows hp > 0 < 99')
			windower.send_command('autows on')
		elseif currentPC.main_job == 'COR' then
			windower.send_command('roller roll1 chaos')
			windower.send_command('roller roll2 rogue')
			windower.send_command('autows use evisceration')
			windower.send_command('autows hp > 0 < 99')
			windower.send_command('autows on')
		end	
	
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
	elseif cmd == 'loadquetz' then
		log('IPC Loading QUETZ addon stuff.')
		coroutine.sleep(delay)
		ipcflag = true
		loadquetz(cmd2)
	elseif cmd == 'refresh' then
		log('IPC Refresh healbot')
		coroutine.sleep(delay)
		ipcflag = true
		refresh()
	end
	
end)