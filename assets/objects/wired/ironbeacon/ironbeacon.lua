
function goodReception()
  if world.underground(object.position()) then
    return false
  end
  
  local ll = object.toAbsolutePosition({ -4.0, 1.0 })
  local tr = object.toAbsolutePosition({ 4.0, 32.0 })
  
  local bounds = {0, 0, 0, 0}
  bounds[1] = ll[1]
  bounds[2] = ll[2]
  bounds[3] = tr[1]
  bounds[4] = tr[2]
  
  return not world.rectCollision(bounds, true)
end

function init(args)
  object.setInteractive(true)
  if not goodReception() then
    object.setAnimationState("beaconState", "idle")
  else
    object.setAnimationState("beaconState", "active")
  end
end

function onInteraction(args)
  if not goodReception() then
    object.setAnimationState("beaconState", "idle")
    return { "ShowPopup", { message = "No signal! Please activate on planet surface." } }
  else
    object.setAnimationState("beaconState", "active")
    world.spawnProjectile("regularexplosion2", object.toAbsolutePosition({ 0.0, 1.0 }))
    object.smash()
    world.spawnMonster("penguinUfo", object.toAbsolutePosition({ 0.0, 32.0 }), { level = 9 })
  end
end

function hasCapability(capability)
  return false
end
