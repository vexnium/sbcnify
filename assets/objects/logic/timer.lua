function init(args)
  object.setInteractive(false)
  if storage.state == nil then
    output(false)
  else
    output(storage.state)
  end
  if storage.timer == nil then
    storage.timer = 0
  end
  self.interval = object.configParameter("interval")
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
  if not object.getInboundNodeLevel(0) then
    if storage.timer == 0 then
      storage.timer = self.interval
      output(not storage.state)
    else
      storage.timer = storage.timer - 1 
    end
  end
end
