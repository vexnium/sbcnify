function init(args)
  if storage.initialized == nil then
    object.setAnimationState("tis1State", "active")
    object.setInteractive(true)
    object.setColliding(false)
    storage.initialized = true
  end
end

function onInteraction(args)
  if isActive() then
  	use(args)
  end
end

function hasCapability(capability)
  if capability == 'tis1' then
    return true
  else
    return false
  end
end

function isActive()
  return object.animationState("tis1State") == "active"
end

function use(args)
  if isActive() then
    object.setAnimationState("tis1State", "expire")
    object.setInteractive(false)
    object.playSound("useSounds")
    
    local projectile = object.randomizeParameter("projectileOptions")
    
    world.spawnProjectile(projectile.projectileType, object.position(), object.id(), args.source, false, projectile.projectileParams)
  end
end
