function init(args)
  object.setInteractive(false)
  if storage.state == nil then
    output(false)
  else
    output(storage.state)
  end
end

function output(state)
  if storage.state ~= state then
    storage.state = state
    object.setAllOutboundNodes(state)
    if state then
      object.setAnimationState("switchState", "on")
    else
      object.setAnimationState("switchState", "off")
    end
  else
  end
end

function main()
  if object.getInboundNodeLevel(1) then
    output(object.getInboundNodeLevel(0))
  end
end
