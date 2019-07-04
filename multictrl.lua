_addon.name = 'Multictrl'
_addon.author = 'Kate'
_addon.version = '1.0.0.0'
_addon.command = 'multi'
require('functions')
require('logger')
config = require('config')

settings = config.load(defaults)

windower.register_event('addon command', function(input, ...)
    local cmd = string.lower(input)
	local args = {...}
	
	if cmd == 'on' then
		on()
	elseif cmd == 'off' then
		off()
	elseif cmd == 'load' then
		loadallstuff()
	elseif cmd == 'followon' then
		followon()
	elseif cmd == 'followoff' then
		followoff()
	elseif cmd == 'stoprun' then
		stoprun()
    end
end)

function stoprun()
	windower.ffxi.run(false)
end

function on()
	log('Turning on stuff...')
	windower.send_command('send ' .. settings.alt1 .. ' input //hb on')
	windower.send_command('send ' .. settings.alt2 .. ' input //hb on')
	windower.send_command('send ' .. settings.alt3 .. ' input //hb on')
	windower.send_command('send ' .. settings.alt3 .. ' input //roller on')
	windower.send_command('hb on')
	windower.send_command('gs c toggle AutoTankMode')
end

function off()
	log('Turning off stuff...')
	windower.send_command('send ' .. settings.alt1 .. ' input //hb off')
	windower.send_command('send ' .. settings.alt2 .. ' input //hb off')
	windower.send_command('send ' .. settings.alt3 .. ' input //hb off')
	windower.send_command('send ' .. settings.alt3 .. ' input //roller off')
	windower.send_command('hb off')
	windower.send_command('gs c toggle AutoTankMode')
end

function followon()
	log('Follow ON')
	windower.send_command('send ' .. settings.alt1 .. ' input //hb follow ' .. settings.main1 .. '')
	windower.send_command('send ' .. settings.alt2 .. ' input //hb follow ' .. settings.main1 .. '')
	windower.send_command('send ' .. settings.alt3 .. ' input //hb follow ' .. settings.main1 .. '')
end


function followoff()
	log('Follow OFF')
	windower.send_command('send ' .. settings.alt1 .. ' input //hb follow off')
	windower.send_command('send ' .. settings.alt2 .. ' input //hb follow off')
	windower.send_command('send ' .. settings.alt3 .. ' input //hb follow off')
end

function loadallstuff()
	log('Load all addons...')
	
	windower.send_command('send ' .. settings.alt1 .. ' input //lua r superwarp')
	windower.send_command('send ' .. settings.alt2 .. ' input //lua r superwarp')
	windower.send_command('send ' .. settings.alt3 .. ' input //lua r superwarp')
	windower.send_command('lua r superwarp')
	windower.send_command('lua r autows')
	windower.send_command('send ' .. settings.alt1 .. ' input //lua r autows')
	windower.send_command('send ' .. settings.alt2 .. ' input //lua r autows')
	windower.send_command('send ' .. settings.alt3 .. ' input //lua r autows')
	
	windower.send_command('send ' .. settings.alt1 .. ' input //lua r healbot')
	windower.send_command('send ' .. settings.alt3 .. ' input //lua r roller')
	windower.send_command('send ' .. settings.alt2 .. ' input //lua r healbot')
	windower.send_command('send ' .. settings.alt3 .. ' input //lua r healbot')
	windower.send_command('lua r healbot')
	coroutine.sleep(5)

	-- Set PLD
	
	windower.send_command('hb mincure 4')
	windower.send_command('autows use savage blade')
	windower.send_command('autows hp > 0 < 99')
	windower.send_command('autows on')

	-- Set WHM melee - ' .. settings.alt2 .. '

	windower.send_command('send ' .. settings.alt2 .. ' input //hb bufflist whm ' .. settings.alt2 .. '')
	windower.send_command('send ' .. settings.alt2 .. ' input //gs disable main')
	windower.send_command('send ' .. settings.alt2 .. ' input //gs disable sub')
	windower.send_command('send ' .. settings.alt2 .. ' input /equip main \'Queller Rod\'; wait 1.0; send ' .. settings.alt2 .. ' input /equip sub \'Bolelabunga\'')
	windower.send_command('send ' .. settings.alt2 .. ' input //hb buff ' .. settings.main1 .. ' haste')
	windower.send_command('send ' .. settings.alt2 .. ' input //hb buff ' .. settings.alt1 .. ' haste')
	windower.send_command('send ' .. settings.alt2 .. ' input //hb buff ' .. settings.alt3 .. ' haste')
	windower.send_command('send ' .. settings.alt2 .. ' input //hb assist ' .. settings.main1 .. '')
	windower.send_command('send ' .. settings.alt2 .. ' input //hb assist attack')
	windower.send_command('send ' .. settings.alt2 .. ' input //hb follow ' .. settings.main1 .. '')
	windower.send_command('send ' .. settings.alt2 .. ' input //hb follow dist 4')
	windower.send_command('send ' .. settings.alt2 .. ' input //autows use hexa strike')
	windower.send_command('send ' .. settings.alt2 .. ' input //autows hp > 0 < 99')
	windower.send_command('send ' .. settings.alt2 .. ' input //autows on')


	-- Set GEO melee


	-- windower.send_command('send ' .. settings.alt3 .. ' input //geo geo frailty')
	-- windower.send_command('send ' .. settings.alt3 .. ' input //geo indi haste')
	-- windower.send_command('send ' .. settings.alt3 .. ' input //geo entrust off')
	-- windower.send_command('send ' .. settings.alt3 .. ' input //hb buff ' .. settings.alt3 .. ' haste')
	-- windower.send_command('send ' .. settings.alt3 .. ' input //hb mincure 4')
	-- windower.send_command('send ' .. settings.alt3 .. ' input //hb assist ' .. settings.main1 .. '')
	-- windower.send_command('send ' .. settings.alt3 .. ' input //hb assist attack')
	-- windower.send_command('send ' .. settings.alt3 .. ' input //hb debuff dia ii')
	-- windower.send_command('send ' .. settings.alt3 .. ' input //hb follow ' .. settings.main1 .. '')
	-- windower.send_command('send ' .. settings.alt3 .. ' input //hb follow dist 4')
	-- windower.send_command('send ' .. settings.alt3 .. ' input //hb weaponskill hexa strike')

	-- Set COR melee

	windower.send_command('send ' .. settings.alt3 .. ' input //roller roll1 chaos')
	windower.send_command('send ' .. settings.alt3 .. ' input //roller roll2 rogue')
	--windower.send_command('send ' .. settings.alt3 .. ' input //hb disable cure')
	windower.send_command('send ' .. settings.alt3 .. ' input //hb assist ' .. settings.main1 .. '')
	windower.send_command('send ' .. settings.alt3 .. ' input //hb assist attack')
	windower.send_command('send ' .. settings.alt3 .. ' input //hb follow ' .. settings.main1 .. '')
	windower.send_command('send ' .. settings.alt3 .. ' input //hb follow dist 4')
	--windower.send_command('send ' .. settings.alt3 .. ' input //hb weaponskill evisceration')
	windower.send_command('send ' .. settings.alt3 .. ' input //autows use evisceration')
	windower.send_command('send ' .. settings.alt3 .. ' input //autows hp > 0 < 99')
	windower.send_command('send ' .. settings.alt3 .. ' input //autows on')

	-- Set WAR

	windower.send_command('send ' .. settings.alt1 .. ' input //hb buff ' .. settings.alt1 .. ' berserk')
	windower.send_command('send ' .. settings.alt1 .. ' input //hb buff ' .. settings.alt1 .. ' hasso')
	windower.send_command('send ' .. settings.alt1 .. ' input //hb buff ' .. settings.alt1 .. ' retaliation')
	windower.send_command('send ' .. settings.alt1 .. ' input //hb buff ' .. settings.alt1 .. ' restraint')
	windower.send_command('send ' .. settings.alt1 .. ' input //hb buff ' .. settings.alt1 .. ' blood rage')
	windower.send_command('send ' .. settings.alt1 .. ' input //hb assist ' .. settings.main1 .. '')
	windower.send_command('send ' .. settings.alt1 .. ' input //hb assist attack')
	windower.send_command('send ' .. settings.alt1 .. ' input //hb follow ' .. settings.main1 .. '')
	windower.send_command('send ' .. settings.alt1 .. ' input //hb follow dist 4')
	--windower.send_command('send ' .. settings.alt1 .. ' input //hb weaponskill upheaval')
	windower.send_command('send ' .. settings.alt1 .. ' input //autows use upheaval')
	windower.send_command('send ' .. settings.alt1 .. ' input //autows hp > 0 < 99')
	windower.send_command('send ' .. settings.alt1 .. ' input //autows on')

	

end