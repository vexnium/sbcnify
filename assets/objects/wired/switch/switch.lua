function init(args)
  object.setInteractive(true)
  object.setAllOutboundNodes(object.animationState("switchState") == "on")
end

function onInteraction(args)
  if object.animationState("switchState") == "off" then
    object.setAnimationState("switchState", "on")
    object.playSound("onSounds");
    object.setAllOutboundNodes(true)
  else
    object.setAnimationState("switchState", "off")
    object.playSound("offSounds");
    object.setAllOutboundNodes(false)
  end
end
