-- Fix de pas mal de choses. Par Gaya.
-- Hook Inventaire
VORP = exports.vorp_inventory:vorp_inventoryApi()

-- Hook User
local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

function CheckIngredients(job,inventory)
	-- Check outil
	if job.IsToolRequired then
	local toolOK = false
		for i,item in ipairs(inventory) do
			-- Pas besoin de check le nombre d'outils, si le label est là, y'en a au moins un.
			if item.name == job.RequiredTool then
				toolOK = true
			end
		end
		if toolOK == false then
		TriggerClientEvent("vorp:TipBottom", source, job.NoRequiredToolInfo, 4000)
			return false
		end
	end
	-- Check Ingredients
	if job.IsIngredientsRequired then
	local itemNotCheckdCheck = false
	for i,itemSearched in ipairs(job.ListOfIngredients) do
		local itemOK = false
		for j,item in ipairs(inventory) do
			if item.name == itemSearched.ItemName and item.count >= itemSearched.ItemNumber then
				itemOK = true
			end
		end
		if itemOK == false then
			TriggerClientEvent("vorp:TipBottom", source, job.NoIngredientsRequiredInfo, 4000)
			return false
		end
	end
	end
	return true
end


-- Je suis pas fan d'envoyer le job en entier a chaque call... Est-ce qu'on pourrait pas envoyer que des bouts ?
RegisterNetEvent("LeMekapGlobalJobs:JobCheck")
AddEventHandler("LeMekapGlobalJobs:JobCheck", function(job)

	local _source = source 
	local user = VorpCore.getUser(_source)
	local Character = user.getUsedCharacter
	local inventory = VORP.getUserInventory(_source)
	
	if CheckIngredients(job, inventory) then
		-- Call au Client de jouer l'anim
		TriggerClientEvent("LeMekapGlobalJobs:PlayAnimation", _source,  job)
		-- Attente de la fin de l'anim, pour éviter les mecs qui feraient du cancel anim pour spammer une action
		Citizen.Wait(job.AnimationTimeInSec * 1000)
		-- Sub ingredients
		if job.IsIngredientsRequired then
			for i,item in ipairs(job.ListOfIngredients) do
				VORP.subItem(_source, item.ItemName, item.ItemNumber)
			end
		end
		-- Récompenses
		if job.IsRewardsRequired then
			for i,item in ipairs(job.ListOfRewards) do
				local nbRewarded = item.ItemNumber
				
				if job.IsRandomReward then
					nbRewarded = math.random(1,item.ItemNumber)
				end
				VORP.addItem(_source, item.ItemName, nbRewarded)
			end
			if job.MoneyReward > 0 then
				Character.addCurrency(0, job.MoneyReward)
			end
		end
		TriggerClientEvent("vorp:TipBottom", _source,job.EndOfJobPrompt, 4000)
	end
end)