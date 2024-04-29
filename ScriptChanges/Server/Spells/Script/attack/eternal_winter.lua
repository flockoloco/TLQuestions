local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat3:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)

--custom area combat
--This should/can go to spells.lua but will remain here for now
arr1 = {
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 1, 1, 0, 0},
	{0, 0, 0, 0, 0, 0, 1, 1, 0, 0},
	{0, 0, 0, 0, 1, 2, 0, 0, 0, 0},
	{0, 0, 1, 1, 1, 1, 0, 0, 0, 0},
	{0, 0, 0, 1, 1, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
}
arr2 = {
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 1, 1, 1, 0, 0, 0},
	{0, 0, 0, 0, 1, 1, 1, 0, 0, 0},
	{0, 0, 0, 1, 1, 0, 1, 1, 0, 0},
	{0, 0, 0, 1, 0, 2, 0, 1, 0, 0},
	{0, 0, 0, 1, 1, 0, 1, 1, 0, 0},
	{0, 0, 0, 0, 1, 1, 1, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
}
arr3 = {
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 1, 1, 1, 0, 0, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 1, 1, 1, 1, 2, 1, 1, 1, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 0, 0, 1, 1, 1, 1, 1, 0, 0},
	{0, 0, 0, 0, 1, 1, 1, 0, 0, 0}
}


setCombatArea(combat, createCombatArea(arr1))
setCombatArea(combat2, createCombatArea(arr2))
setCombatArea(combat3, createCombatArea(arr3))

function onGetFormulaValues(player, level, magicLevel)
	local min = (player:getLevel() / 5) + (skill * attack * 0.02) + 4
	local max = (player:getLevel() / 5) + (skill * attack * 0.03) + 6
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function combatSpell(creature, variant, combat)
	combat:execute(creature, variant)
end

function onCastSpell(creature, variant)

	addEvent(combatSpell, 0, creature:getId(), variant, combat)
	addEvent(combatSpell, 500, creature:getId(), variant, combat2)
	addEvent(combatSpell, 1000, creature:getId(), variant, combat3)
	return true
end
