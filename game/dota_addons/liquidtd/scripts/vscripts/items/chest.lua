function chest_open(keys)
	local item_list = LoadKeyValues("scripts/kv/chest_result.kv") --Here we load a kv file where we will put all the item you can find in chest
	local caster = keys.caster
	local Player_ID = caster:GetPlayerOwnerID() 
	local item = keys.ability
	local gold = 0
	if keys.gold >0 then
		gold = keys.gold_amt + math.random(-(keys.gold_rand),(keys.gold_rand))
	end
	caster:RemoveItem(item)--Here we remove the chest
	local chest_name = keys.chest_name

	item_list = item_list[chest_name] --Here we load the item list specific to this chest
	local len = 0
	for k,v in pairs( item_list ) do
		len = len + 1
	end
	local item_number = 0
	if keys.gold == 1 then
		item_number = math.random(1,(len + 1)) --here we determine the item number (so we chose the item), the +1 is to add the gold chance in ,you can change it to 2 or more if you want gold to have higger change of appear)
	else
		item_number = math.random(1,len)
	end
	if item_number > len then --in case the player obtaine gold instead of item
	       PlayerResource:ModifyGold(Player_ID, gold, true, 0 ) 
	else
		local item_name = item_list[tostring(item_number)] -- i know it could be better , but i'm not realy used to kv
		local item_reward = CreateItem( item_name, caster, caster )
		caster:AddItem(item_reward)
		if keys.gold == 2 then
			PlayerResource:ModifyGold(Player_ID, gold, true, 0 ) 
		end
	end
end