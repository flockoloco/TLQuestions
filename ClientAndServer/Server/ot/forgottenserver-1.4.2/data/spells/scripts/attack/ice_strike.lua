local combat = Combat()

--Tile.h tiles Flags to avoid
local unwanted_tilestates = { 
TILESTATE_FLOORCHANGE, 
TILESTATE_PROTECTIONZONE,
TILESTATE_TELEPORT,
TILESTATE_MAGICFIELD,
TILESTATE_MAILBOX,
TILESTATE_TRASHHOLDER,
TILESTATE_BED,
TILESTATE_BLOCKSOLID, 
TILESTATE_BLOCKPATH,
TILESTATE_IMMOVABLEBLOCKSOLID,
TILESTATE_IMMOVABLEBLOCKPATH,
TILESTATE_IMMOVABLENOFIELDBLOCKPATH,
TILESTATE_NOFIELDBLOCKPATH,
TILESTATE_SUPPORTS_HANGABLE
}

function dash(creature)
    --distance to travel
    local distance = 5
    --future position
    local toPosition
    --basic for loop
    for i = 1, distance do
        --get player current position
        toPosition = creature:getPosition()
        --get future next 1 tile position
        toPosition:getNextPosition(creature:getDirection(), 1)
        --Check for tile
        local tile = toPosition and Tile(toPosition)
        if not tile then
            return false
        end
        --check for each tile we dont want, if has flag unwanted stop dash
        for _, tilestate in pairs(unwanted_tilestates) do
            if tile:hasFlag(tilestate) then
                return false
            end
        end
        --Not the shader but a real nice effect
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        --move player to next position
        creature:teleportTo(toPosition)
        --another effect
        toPosition:sendMagicEffect(CONST_ME_TELEPORT)
    end

end

function onCastSpell(creature, variant)
    dash(creature)
    return 
end