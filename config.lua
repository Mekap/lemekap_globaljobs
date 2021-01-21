Config = { }

-- If you put a IsXRequired to false, you dont have to specify following instructions.
-- The example job has everything setup to true so you can see how each thing works
-- For a job to succesfully begin, it'll look for a tool, then for ingqredients, then its gonna play an animation & give you the proper rewards.
-- The tool is never removed, ingredients are.
-- the animations are based on scenario, you can find em online https://www.mod-rdr.com/wiki/pages/list-of-rdr2-scenarios/
-- Make sure that you have proper animations for male & woman, doesnt always work properly on both of em.
-- This plugin is best used for small flavor animation or basic jobs, requiring minimal coding, just configuration.

Config.Jobs = {	
{
	["JobName"] = "Test LeMekap", -- Not used, just for us
	["JobCoords"] = vector3(-245.3123,  812.9736, 122.7152), -- X, y,z
	["JobDistance"] = 3.0, -- Distance (Make sure to put the .0)
	["JobAnnonce"] = "Appuyez sur [~e~G~q~] pour rendre hommage à [~e~ Cooper~q~]", -- Prompt
	["JobCooldown"] = 25, -- CD
	
	-- Blip demandé ?
	["IsBlipRequired"] = true, -- Besoin d'un blip ?
	["BlipHash"] = 1106719664, -- ID du blip
	["BlipText"] = "Test LeMekap", -- Texte affichée sur la map
	
	-- Is Ped Required ?
	["IsPedRequired"] = true,
	["PedHashModel"] ="CS_CIGCARDGUY",
	["PedX"] =-245.3123,
	["PedY"] =812.9736,
	["PedZ"] = 122.7152, 
	["PedH"] =37.45,
	
	-- Outil demandé ? 
	["IsToolRequired"] = true,
	
	["RequiredTool"] = "consumable_coffee",  -- wont be removed
	 ["NoRequiredToolInfo"] = "You need a tool", 
	-- Ingrédients demandés ?
	["IsIngredientsRequired"] = true,
	-- Liste of ingredients
	-- ItemName => DbName.
	-- ItemNumber => # to be removed
	["ListOfIngredients"] = {
				{["ItemName"] = "consumable_coffee", ["ItemNumber"] = 1}
	},
	["NoIngredientsRequiredInfo"] = "You need 1 coffee to pray my dude", -- Not enough items
	
	
	-- Récompenses demandés ?
	["IsRewardsRequired"] = true, 
	
	["IsRandomReward"] = false, -- If set to true, will reward 1 to ItemNumber of each Reward
	["ListOfRewards"] = {
				{["ItemName"] = "consumable_coffee", ["ItemNumber"] = 3},
				},
	["MoneyReward"]    = 0, -- $  to be added
	
	-- Scénarios.
	["ScenarioFemale"] = "WORLD_HUMAN_GRAVE_MOURNING",
	["ScenarioMale"] = "WORLD_HUMAN_GRAVE_MOURNING",
	["AnimationTimeInSec"] = 15,
	["AnimationInfo"] = "You're praying ...", -- Message printed during animation

	["EndOfJobPrompt"] = "You just prayed ! And triple your coffee" -- End Of job message
},
}