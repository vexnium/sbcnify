function init(args)
  object.setInteractive(false)
  if storage.state == nil then
    output(false)
  else
    object.setAllOutboundNodes(storage.state)
    if storage.state then
      object.setAnimationState("switchState", "on")
    else
      object.setAnimationState("switchState", "off")
    end
  end
  self.gates = object.configParameter("gates")
  self.truthtable = object.configParameter("truthtable")
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
  end
end

function toIndex(truth)
  if truth then
    return 2
  else
    return 1
  end
end

function main()
  if self.gates == 1 then
    output(self.truthtable[toIndex(object.getInboundNodeLevel(0))])
  elseif self.gates == 2 then
    output(self.truthtable[toIndex(object.getInboundNodeLevel(0))][toIndex(object.getInboundNodeLevel(1))])
  elseif self.gates == 3 then
    output(self.truthtable[toIndex(object.getInboundNodeLevel(0))][toIndex(object.getInboundNodeLevel(1))][toIndex(object.getInboundNodeLevel(2))])
  end
end
