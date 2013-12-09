function init(args)
  object.setInteractive(false)
  object.setAnimationState("switchState", "on")
end

function shallowTabelEquals(tbl1,tbl2)
    for k,v in pairs(tbl1) do
        if (tbl2[k] ~= v) then
            return false
        end
    end
    return true
end

function main()
  if world.isVisibleToPlayer(object.boundBox()) then
    return nil
  end
  local npcSpecies = object.randomizeParameter("spawner.npcSpeciesOptions")
  local npcType = object.randomizeParameter("spawner.npcTypeOptions")
  local npcParameter = object.randomizeParameter("spawner.npcParameterOptions")
  npcParameter.scriptConfig = { spawnedBy = object.position() }
  world.spawnNpc(object.toAbsolutePosition({ 0.0, 2.0 }), npcSpecies, npcType, object.level(), 0, npcParameter);
  object.smash()
end
