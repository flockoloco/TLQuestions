--Window, Button and ProtocolGame
local clickGameWindow
local clickGameButton
local protocolGame = g_game.getProtocolGame()
--Buffer for extendedopcode
local codeBuffer = 0
--Button to click
local clickB = nil
--Timer for callback function
local delay = 50
local repeatDelay = 100

function init()
  ProtocolGame.registerExtendedOpcode(15, clickGamecode)
  clickGameWindow = g_ui.displayUI('clickGame')
  clickGameWindow:hide()

  clickGameButton = modules.client_topmenu.addLeftGameButton('clickGameButton', tr('click game'), '/images/topbuttons/particles', toggle)
  clickB = clickGameWindow:getChildById('clickMe')

end

function terminate()

  ProtocolGame.unregisterExtendedOpcode(15, clickGamecode)
  clickGameWindow:destroy()
  clickGameButton:destroy()
  
end

function toggle()
  if clickGameWindow:isVisible() then
    hide()
  else
    show()
  end
end

function show()
  clickGameWindow:show()
  clickGameWindow:raise()
  clickGameWindow:focus()
 
  if protocolGame then
    protocolGame:sendExtendedOpcode(15, "Refresh")
    --pretty much like an update function/addEvent.
    periodicalEvent(update, function() return clickGameWindow and clickGameWindow:isVisible() end, delay, repeatDelay)
  end   
end

function hide()
  clickGameWindow:hide()
end

function update()
  --If button < window set position to right side
  local offSet = 10
  if (clickB:getX() <= (clickGameWindow:getX() + offSet) ) then
    clickB:setX(( clickGameWindow:getX() + clickGameWindow:getWidth() - (clickB:getWidth() - offSet) ))
  end
  -- distance = movement move to left
  local distance = 10
  clickB:setX(clickB:getX() - distance)
end

function click(codeBuffer)
  --@OnCLick OTUI
  --Set new random PosY
  local jump = math.random((clickGameWindow:getY() + clickB:getHeight() ), (clickGameWindow:getY() + clickGameWindow:getHeight() - clickB:getHeight()))
  clickB:setY(jump)
  
end
-- Protocol thing
function clickGamecode()
  return
end