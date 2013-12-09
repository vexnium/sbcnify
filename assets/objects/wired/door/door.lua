function init(args)
  object.setColliding(true)

  if isDoorClosed() then
    object.setColliding(true)
    object.setAllOutboundNodes(true)
  else
    object.setColliding(false)
    object.setAllOutboundNodes(false)
  end

  onNodeConnectionChange()
end

function onNodeConnectionChange(args)
  object.setInteractive(not object.isInboundNodeConnected(0))
  if object.isInboundNodeConnected(0) then
    onInboundNodeChange({ level = object.getInboundNodeLevel(0) })
  end
end

function onInboundNodeChange(args)
  if args.level then
    openDoor(-doorDirection())
  else
    closeDoor()
  end
end

function onInteraction(args)
  if (object.isInboundNodeConnected(0)) then
    return
  end
  if isDoorClosed() then
    openDoor(args.source[1])
  else
    closeDoor()
  end
end

function hasCapability(capability)
  if (object.isInboundNodeConnected(0)) then
    return
  end
  if capability == 'door' then
    return true
  elseif capability == 'closedDoor' then
    return isDoorClosed()
  else
    return false
  end
end

function isDoorClosed()
  return object.animationState("doorState") == "closeLeft" or object.animationState("doorState") == "closeRight"
end

function doorDirection()
  return (object.animationState("doorState") == "closeLeft" or object.animationState("doorState") == "openLeft") and -object.direction() or object.direction()
end

function closeDoor()
  if not isDoorClosed() then
    if object.animationState("doorState") == "openLeft" then
      object.setAnimationState("doorState", "closeLeft")
    else
      object.setAnimationState("doorState", "closeRight")
    end
    object.playSound("closeSounds")
    object.setColliding(true)
    object.setAllOutboundNodes(true)
  end
end

function openDoor(direction)
  if isDoorClosed() then
    if direction == nil or direction * object.direction() < 0 then
      object.setAnimationState("doorState", "openLeft")
    else
      object.setAnimationState("doorState", "openRight")
    end
    object.playSound("openSounds")
    object.setColliding(false)
    object.setAllOutboundNodes(false)
  end
end
