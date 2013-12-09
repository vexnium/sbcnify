function init()
  self.spawnedEntityId = nil

  self.state = stateMachine.create({
    "spawnState"
  })
  self.state.leavingState = function(stateName)
    object.setAnimationState("movement", "idle")
  end

  object.setAnimationState("movement", "idle")
  object.setInteractive(false)
end

function main()
  if self.spawnedEntityId ~= nil and not world.entityExists(self.spawnedEntityId) then
    self.spawnedEntityId = nil
  end

  self.state.update(object.dt())
end

--------------------------------------------------------------------------------
spawnState = {}

function spawnState.enter()
  if self.spawnedEntityId ~= nil then return nil end

  return { timer = 0, spawned = false }
end

function spawnState.update(dt, stateData)
  local animation = object.animationState("movement")
  if animation == "idle" then
    if stateData.spawned then
      return true, object.configParameter("spawnCooldownTime")
    else
      object.setAnimationState("movement", "spawn")
    end
  elseif animation == "spawn" then
    stateData.timer = stateData.timer + dt

    if not stateData.spawned and stateData.timer > object.configParameter("spawnTime") then
      self.spawnedEntityId = world.spawnNpc(spawnState.spawnPosition(), "apex", "default", object.level())
      stateData.spawned = true
    end
  elseif animation == "idleOpen" then
    stateData.timer = stateData.timer + dt

    if stateData.timer > object.configParameter("closeTime") then
      object.setAnimationState("movement", "close")
    end
  end

  return false
end

function spawnState.spawnPosition()
  return vec2.add(object.position(), object.configParameter("spawnOffset"))
end