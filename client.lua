-- Scripts Cote client / Par Gaya

-- Liste des Jobs
local jobs = {}


function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function CreateBlip(job)
	if job.IsBlipRequired then
		local x, y, z = table.unpack(job.JobCoords)
		local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, x, y, z)
		SetBlipSprite(blip, job.BlipHash, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, job.BlipText)
        
	end
end

-- Ca va etre la mission des mecs qui font la config de trouver les bons scénarios, aussi bien pour meufs que pours mecs.
-- Est-ce qu'on pourrait 
RegisterNetEvent("LeMekapGlobalJobs:PlayAnimation")
AddEventHandler("LeMekapGlobalJobs:PlayAnimation", function(job)
	local scenario = job.ScenarioMale
	local playerPed = PlayerPedId()	
	if not IsPedMale(playerPed) then
	scenario = job.ScenarioFemale
	end

	TaskStartScenarioInPlace(playerPed, GetHashKey(scenario), job.AnimationTimeInSec * 1000, true, false, false, false)
	TriggerEvent("vorp:TipRight", job.AnimationInfo, job.AnimationTimeInSec * 1000)
	Citizen.Wait(job.AnimationTimeInSec * 1000)
	-- Clear de la tache, et on les désarmes aussi.
	ClearPedTasks(playerPed)
    SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
end)

function CreatePnj(job)
	local hashModel = GetHashKey(job.PedHashModel) 
	if IsModelValid(hashModel) then 
		RequestModel(hashModel)
		while not HasModelLoaded(hashModel) do                
				Wait(100)
		end
	else 
		print(job.PedHashModel .. " pas valide !!!")
	end 
	local npc = CreatePed(hashModel, job.PedX, job.PedY, job.PedZ, job.PedH, false, true, true, true)
	Citizen.InvokeNative(0x283978A15512B2FE, npc, true) -- SetRandomOutfitVariation
	SetEntityNoCollisionEntity(PlayerPedId(), npc, false)
	SetEntityCanBeDamaged(npc, false)
	SetEntityInvincible(npc, true)
	Wait(1000)
	FreezeEntityPosition(npc, true) -- NPC can't escape
	SetBlockingOfNonTemporaryEvents(npc, true) -- NPC can't be scared	
end



function Start()
local configUnion = {}
for i,job in ipairs(Config.Jobs) do
	table.insert(configUnion, job)
end
print("LMK:JobsLoaded ")
print(#configUnion)
jobs = configUnion
for i,job in ipairs(jobs) do
	Citizen.CreateThread(function()
		--Blip
		CreateBlip(job)
		if job.IsPedRequired then
			CreatePnj(job)
		end
		-- Boucle de job
		 while true do
			local playerCoords = GetEntityCoords(PlayerPedId())  
			if Vdist(playerCoords, job.JobCoords) <= job.JobDistance then
				 DrawTxt(job.JobAnnonce, 0.50, 0.85, 0.7, 0.7, true, 255, 255, 255, 255, true)
				if IsControlJustPressed(2, 0x760A9C6F) then -- 0x760A9C6F = G
					-- Ca parait logique, c'est le serveur qui va faire les checks. 
					-- et lancer les anims si il faut. On attends le temps mini de l'anim par contre
					TriggerServerEvent("LeMekapGlobalJobs:JobCheck", job)
					Citizen.Wait(job.JobCooldown * 1000)
                end
			end
			Citizen.Wait(1)           
		end 
	end)
end

end
Start()