extends RefCounted
class_name Enums

enum StatusEffect {
	Stun,
	Slow,
}

enum RewardCategory {
	Player,
	Dash,
	Fireball,
	Locust,
	Lightning
}

enum Reward {
	HealthBoost,
	ManaBoost,
	SpeedBoost,
	SpellCost,
	SpellDamage,
	RunCost,
	RunSpeed,
	MeleeLifesteal,
	MeleeDamage,
	
	DashCost,
	DashSpeed,
	DashDamage,
	DashImmunity,
	
	FireballCost,
	
	LocustCost,
	
	LightningCost,
}

const REWARD_CATEGORY = {
	RewardCategory.Player: {"label": "Player", "icon": "res://game/UI_Elements/reward_screen/Card_Player.png"},
	RewardCategory.Dash: {"label": "Dash", "icon": "res://game/UI_Elements/reward_screen/Card_Player.png"},
	RewardCategory.Fireball: {"label": "Fireball", "icon": "res://game/UI_Elements/reward_screen/Card Blank_Fire.png"},
	RewardCategory.Locust: {"label": "Locust", "icon": "res://game/UI_Elements/reward_screen/Card_Blank_bug.png"},
	RewardCategory.Lightning: {"label": "Lightning", "icon": "res://game/UI_Elements/reward_screen/Card Blank_Lighening.png"},
}

const REWARDS = {
	Reward.HealthBoost: 		{"category": RewardCategory.Player, 		"amount": 50, 	"text": "+ Health"},
	Reward.ManaBoost: 			{"category": RewardCategory.Player, 		"amount": 50, 	"text": "+ Mana"},
	Reward.SpeedBoost: 			{"category": RewardCategory.Player, 		"amount": 2, 	"text": "+ Speed"},
	Reward.SpellCost: 			{"category": RewardCategory.Player, 		"amount": 0.75, 	"text": "- Spell Cost"},
	Reward.SpellDamage: 		{"category": RewardCategory.Player, 		"amount": 10, 	"text": "+ Spell Damage"},
	Reward.RunCost: 			{"category": RewardCategory.Player, 		"amount": 0.5, 	"text": "- Run Cost"},
	Reward.RunSpeed: 			{"category": RewardCategory.Player, 		"amount": 2, 	"text": "+ Run Speed"},
	Reward.MeleeLifesteal: 		{"category": RewardCategory.Player, 		"amount": 10, 	"text": "Melee\nLife Steal"},
	Reward.MeleeDamage: 		{"category": RewardCategory.Player, 		"amount": 10, 	"text": "+ Melee Damage"},
	Reward.DashCost: 			{"category": RewardCategory.Dash, 			"amount": 0.5, 	"text": "- Mana Cost"},
	Reward.DashSpeed: 			{"category": RewardCategory.Dash, 			"amount": 20, 	"text": "+ Dash Speed"},
	Reward.DashDamage: 			{"category": RewardCategory.Dash, 			"amount": 15, 	"text": "Dash Deals Damage"},
	Reward.DashImmunity: 		{"category": RewardCategory.Dash, 			"amount": 0, 	"text": "Immune While Dashing"},
	Reward.FireballCost: 		{"category": RewardCategory.Fireball, 		"amount": 0.5, 	"text": "- Mana Cost"},
	Reward.LocustCost: 			{"category": RewardCategory.Locust, 		"amount": 0.5, 	"text": "- Mana Cost"},
	Reward.LightningCost: 		{"category": RewardCategory.Lightning, 		"amount": 0.5, 	"text": "- Mana Cost"},
}

enum Song {
	MENU,
	HOME,
	DESERT,
	HELL,
	HEAVEN,
	REWARD,
	SCORE,
}
