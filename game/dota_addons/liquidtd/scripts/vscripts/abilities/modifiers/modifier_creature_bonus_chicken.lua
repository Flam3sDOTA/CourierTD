modifier_creature_bonus_chicken = class({})

--------------------------------------------------------------------------------

function modifier_creature_bonus_chicken:IsPurgable()
	return false;
end

--------------------------------------------------------------------------------

function modifier_creature_bonus_chicken:IsHidden()
	return true;
end

--------------------------------------------------------------------------------

function modifier_creature_bonus_chicken:OnCreated( kv )
	self.total_gold = self:GetAbility():GetSpecialValueFor( "total_gold" )
	self.gold_bag_duration = self:GetAbility():GetSpecialValueFor( "gold_bag_duration" )
	if IsServer() then
		self.flAccumDamage = 0
		self.nBagsDropped = 0
		self:StartIntervalThink( 3.0 )
	end
end

--------------------------------------------------------------------------------

function modifier_creature_bonus_chicken:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_creature_bonus_chicken:OnIntervalThink()
	if not IsServer() then
		return
	end
end

--------------------------------------------------------------------------------

function modifier_creature_bonus_chicken:OnTakeDamage( params )
	if IsServer() then
		local hUnit = params.unit
		local hAttacker = params.attacker
		if hAttacker == nil or hAttacker:IsBuilding() then
			return 0
		end
		if hUnit == self:GetParent() then		
			local flDamage = params.damage
			if flDamage <= 0 then
				return
			end
			self.flAccumDamage = self.flAccumDamage + flDamage
			if self.flAccumDamage >= 50 then
				local newItem = CreateItem( "item_bag_of_gold", nil, nil )
				local nGoldAmount = 20
				newItem:SetPurchaseTime( 0 )
				newItem:SetCurrentCharges( nGoldAmount )
					
				local drop = CreateItemOnPositionSync( hUnit:GetAbsOrigin(), newItem )
				local pos = hUnit:GetAbsOrigin()
				local pos_launch = pos+RandomVector(RandomFloat(150,200))
				newItem:LaunchLoot( true, 50, 0.75, pos_launch )
				newItem:SetLifeTime( self.gold_bag_duration )
				
				self.flAccumDamage = self.flAccumDamage - 50
				self.nBagsDropped = self.nBagsDropped + 1
				self.total_gold = self.total_gold - 20
				
				for _, item in pairs(Entities:FindAllByClassname("dota_item_drop")) do
					if item:GetContainedItem() == newItem then
						item:SetModelScale(1.8)
					end
				end
			end
		end
	end

	return 0
end

--------------------------------------------------------------------------------

function modifier_creature_bonus_chicken:CheckState()
	local state = {}
	if IsServer()  then
		state =
		{
			[MODIFIER_STATE_STUNNED] = false,
			[MODIFIER_STATE_ROOTED] = false,
		}
	end
	
	return state
end


--------------------------------------------------------------------------------

function modifier_creature_bonus_chicken:GetPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end