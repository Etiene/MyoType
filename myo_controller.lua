scriptId = 'com.hacklondon.myotype'
scriptTitle = "MyoType"
scriptDetailsUrl = "" -- We don't have this until it's submitted to the Myo Market

local right = false
local left = false
local  internal_clock = 0
local scroll = false

function onPoseEdge(pose, edge)
    myo.debug("onPoseEdge: " .. pose .. ", " .. edge)
    if pose == 'waveIn' and edge =='on' then
    	left = true
        internal_clock = 0
    	myo.keyboard("left_arrow", "press")
    
    elseif pose == 'waveOut' and edge =='on'  then
    	right = true
        internal_clock = 0
    	myo.keyboard("right_arrow", "press")
    

    elseif pose == 'fist' and edge =='on'  then
    	myo.keyboard("down_arrow", "press")
    
    elseif pose == 'doubleTap' and edge =='on'  then
    	myo.keyboard("space", "press")
    
    elseif pose == 'rest' and edge =='on'  then
    	left = false
    	right = false
        internal_clock = 0
    	myo.keyboard("left_arrow", "up")
    	myo.keyboard("right_arrow", "up")
    end   
end

function onPeriodic()
	internal_clock = internal_clock + 10
	myo.unlock()
    --myo.debug("what")
    if left or right and internal_clock == 400 then 
        scroll = true 
        internal_clock = 0
    end
	if internal_clock == 100 and  scroll then
		
        
		if right == true then
            myo.debug("move"..internal_clock)
			myo.keyboard("right_arrow", "press")
            scroll = false
		elseif left == true then
			myo.keyboard("left_arrow", "press")
            myo.debug("move"..internal_clock)
            scroll = false
            internal_clock = 0
		end

	end
	--myo.debug("Test")
end

function onForegroundWindowChange(app, title)
    myo.debug("onForegroundWindowChange: " .. app .. ", " .. title)
    return true
end

function activeAppName()
    return "Output Everything"
end

function onActiveChange(isActive)
	myo.unlock()
    myo.debug("onActiveChange")
end



