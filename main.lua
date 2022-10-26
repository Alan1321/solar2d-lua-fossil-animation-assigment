--Name: Alan Subedi
--CS-371 (Fall 2022)

--importing widget library here
local widget = require( "widget" )  

--if touch is true then slider is diabled and touch is enabled else the opposite is true
local touch = true                  

--these 5 variables keep track of where or not head, caudal, pelvic, anal, soft were previously turned on during the touch portion
--initially it is false because they are off when the program starts
local head = false
local caudal_fin = false
local pelvic_fin = false
local anal_fin = false
local soft_ray = false

--these 5 variables keep track of the slider values for each of the different sprite components
--these values will later be used to disable the slider when touch is clicked
local head_value = 0
local caudal_value = 0
local pelvic_value = 0
local anal_value = 0
local soft_value = 0
local h_value = 50

--these are global slider variables for each of the 5 sliders
local sliderHead
local sliderCaudal
local sliderAnal
local sliderPelvic
local sliderSoft
local sliderH

--these are 5 different sounds for 5 different sprite components
local s1 = audio.loadSound( "sound1.wav" );
local s2 = audio.loadSound( "sound2.wav" );
local s3 = audio.loadSound( "sound3.wav" );
local s4 = audio.loadSound( "sound4.wav" );
local s5 = audio.loadSound( "sound5.wav" );

--in this portion i am setting the different frames for the sprite components
local opt =
{
	frames = {
        { x = 11, y = 93, width = 58, height = 57}, -- head frame1
        { x = 70, y = 94, width = 58, height = 54}, -- head frame 2
        { x = 129, y = 93, width = 54, height = 56}, -- head frame 3
        { x = 185, y= 94, width = 52, height = 55}, -- head frame 4
        { x = 12, y = 150, width = 66, height = 54}, -- caudal fin Frame 1 -- 5
        { x = 84, y = 151, width = 60, height = 52}, -- caudal fin Frame 2 
        { x = 149, y = 152, width = 55, height = 51}, -- caudal fin Frame 3
        { x = 209, y = 151, width = 56, height = 53}, -- caudal fin Frame 4
        { x = 273, y = 151, width = 51, height = 53}, -- caudal fin Frame 5
        { x = 13, y = 218, width = 52, height = 29}, -- pelvic fin Frame 1  -- 10
        { x = 68, y = 219, width = 52, height = 24}, -- pelvic fin Frame 2
        { x = 122, y = 218, width = 52, height = 21}, -- pelvic fin Frame 3
        { x = 178, y = 219, width = 68, height = 26}, -- anal fin Frame 1 -- 13
        { x = 248, y = 219, width = 68, height = 29}, -- anal fin Frame 2
        { x = 15, y = 256, width = 62, height = 35}, -- wing top -- 15
        { x = 86, y = 259, width = 56, height = 24}, -- wing below -- 16
        { x = 145, y = 259, width = 29, height = 25}, -- soft ray Frame 1 -- 17
        { x = 176, y = 260, width = 31, height = 24}, -- soft ray Frame 2
        { x = 209, y = 263, width = 30, height = 21}, -- soft ray Frame 3
        {x = 49, y = 297, width = 225, height = 99}, -- All combined -- 20
        {x = 14, y = 7, width = 148, height = 73} -- mainbody
	}
}

--here I am connecting the previous frame to which image the those should be using for it
local sheet = graphics.newImageSheet( "dragon.png", opt);

--these are the different sequence for each of the frame compoennt
--for exmaple head uses frame 1,2,3,4 and those can switch every 800mil,  -> similar for others
local seqData = {
	{name = "head", frames={1,2,3,4}, time=800},
	{name = "caudal_fin", frames={5,6,7,8,9}, time = 800},
    {name = "pelvic_fin", frames={10,11,12}, time = 800},
    {name = "anal_fin", frames={13,14}, time = 800},
    {name = "wing_top", start=15 ,count = 1, time=800},
    {name = "wing_below", start=16 ,count = 1, time=800},
    {name = "soft_ray", frames={17,18,19}, time = 800},
    {name = "all_combined", start=20 ,count = 1, time=800},
    {name = "main_body", start=21, count=1, time=800}
}

--these two variables are init x and y co-ordinates which the different sprite
--compoennts will be using as a refrences later
local xRef = display.contentCenterX - 700
local yRef = 250

--adding head compoennt to the appropriate co-ordinate
local anim = display.newSprite (sheet, seqData);
anim.anchorX = 0.5;
anim.anchorY = 0.5;
anim.x = xRef;
anim.y = yRef;
anim.xScale = 3;
anim.yScale = 3;
anim:setSequence("head");
anim:pause();

--adding mainbody compoennt to the appropriate co-ordinate
local anim2 = display.newSprite (sheet, seqData);
anim2.anchorX = 0.5;
anim2.anchorY = 0.5;
anim2.x = xRef + 170;
anim2.y = yRef - 70;
anim2.xScale = 3;
anim2.yScale = 3;
anim2:setSequence("main_body");
anim2:pause();

--adding wing compoennt to the appropriate co-ordinate
local anim3 = display.newSprite (sheet, seqData);
anim3.anchorX = 0.5;
anim3.anchorY = 0.5;
anim3.x = xRef + 270;
anim3.y = yRef - 165;
anim3.xScale = 3;
anim3.yScale = 3;
anim3:setSequence("wing_top");
anim3:pause();

--adding pelvicFin compoennt to the appropriate co-ordinate
local anim4 = display.newSprite (sheet, seqData);
anim4.anchorX = 0.5;
anim4.anchorY = 0.5;
anim4.x = xRef + 145;
anim4.y = yRef + 25;
anim4.xScale = 3;
anim4.yScale = 3;
anim4:setSequence("pelvic_fin");
anim4:pause();

--adding analFin compoennt to the appropriate co-ordinate
local anim5 = display.newSprite (sheet, seqData);
anim5.anchorX = 0.5;
anim5.anchorY = 0.5;
anim5.x = xRef + 345;
anim5.y = yRef + 25;
anim5.xScale = 3;
anim5.yScale = 3;
anim5:setSequence("anal_fin");
anim5:pause();

--adding softRay compoennt to the appropriate co-ordinate
local anim6 = display.newSprite (sheet, seqData);
anim6.anchorX = 0.5;
anim6.anchorY = 0.5;
anim6.x = xRef + 345;
anim6.y = yRef - 135;
anim6.xScale = 3;
anim6.yScale = 3;
anim6:setSequence("soft_ray");
anim6:pause();

--adding caudalFin compoennt to the appropriate co-ordinate
local anim7 = display.newSprite (sheet, seqData);
anim7.anchorX = 0.5;
anim7.anchorY = 0.5;
anim7.x = xRef + 460;
anim7.y = yRef - 50;
anim7.xScale = 3;
anim7.yScale = 3;
anim7:setSequence("caudal_fin");
anim7:pause();

--adding all the different frame to the same group
local group = display.newGroup()
group:insert(anim)
group:insert(anim2)
group:insert(anim3)
group:insert(anim4)
group:insert(anim5)
group:insert(anim6)
group:insert(anim7)

--the whole group's x is moved by 500
group.x = 10 * 50

--this method is called when the touch is true/false
--if the touch is true and one of the sprite component is called then it is either turned on or off based on
--the boolean variable that was set before and it is also constantly updated here as well.
--audio is played as well based on every click to each sprite body component 
local function spriteListener( event )
    if touch == true then
        if event.target.sequence == 'head' then
            if head == true then
                audio.play(s1);
                head = false
                anim:setFrame(1)
                anim:pause()
            else
                audio.play(s1);
                head = true
                anim:play()
            end
        end
        if event.target.sequence == 'pelvic_fin' then
            if pelvic_fin == true then
                audio.play(s2);
                pelvic_fin = false
                anim4:setFrame(1)
                anim4:pause()
            else
                audio.play(s2);
                pelvic_fin = true
                anim4:play()
            end
        end
        if event.target.sequence == 'anal_fin' then
            if anal_fin == true then
                audio.play(s3);
                anal_fin = false
                anim5:setFrame(1)
                anim5:pause()
            else
                audio.play(s3);
                anal_fin = true
                anim5:play()
            end
        end
        if event.target.sequence == 'soft_ray' then
            if soft_ray == true then
                audio.play(s4);
                soft_ray = false
                anim6:setFrame(1)
                anim6:pause()
            else
                audio.play(s4);
                soft_ray = true
                anim6:play()
            end
        end
        if event.target.sequence == 'caudal_fin' then
            if caudal_fin == true then
                audio.play(s5);
                caudal_fin = false
                anim7:setFrame(1)
                anim7:pause()
            else
                audio.play(s5);
                caudal_fin = true
                anim7:play()
            end
        end
    end
end

--in this section, tap event listeners to each of the sprite component is being added
anim:addEventListener("tap", spriteListener) -- head
anim4:addEventListener("tap", spriteListener) -- pelvic
anim5:addEventListener("tap", spriteListener) -- anal
anim6:addEventListener("tap", spriteListener) -- soft
anim7:addEventListener("tap", spriteListener) -- caudal

--if touch radio button is selected then it is set to true
--if slider radio button is selected then touch is set to false and hence slider is true as a result
local function onSwitchPress(event)
    if event.target.id == 'RadioButton1' then
        touch = true
    else
        touch = false
    end
end

--again, buttonX and buttonY serves as refrences for co-ordinates to the radio buttons
local buttonX = -300
local buttonY = display.contentCenterY + 100

--initializing group for the radio-button
local button_group = display.newGroup()

--adding Touch text at the given co-ordinate
local myText = display.newText( "Touch", buttonX + 180, buttonY+30, native.systemFont, 50 )
myText:setFillColor( 1, 1, 1 )
--adding touch radio-button
local radioButton1 = widget.newSwitch(
    {
        left = buttonX,
        top = buttonY,
        style = "radio",
        id = "RadioButton1",
        label="ssupppppppppp",
        labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1} },
        width=70,
        height=70,
        initialSwitchState = true,
        onPress = onSwitchPress
    }
)
--adding touch radio button to the button group
button_group:insert(radioButton1)

--adding Slider text at the given co-ordinate
local myText2 = display.newText( "Slider", buttonX + 180, buttonY+130, native.systemFont, 50 )
myText2:setFillColor( 1, 1, 1 )
--adding slider radio-button
local radioButton2 = widget.newSwitch(
    {
        left = buttonX,
        top = buttonY + 100,
        style = "radio",
        id = "RadioButton2",
        width=70,
        height=70,
        onPress = onSwitchPress
    }
)
--adding slider radio button to the button group
button_group:insert(radioButton2)

--this function is basically a slider event listener
--if touch is false then we basically set the frame of whatever slider component is
--selected
--if touch is true then we do spriteComponent:setValue( whatever sprite is ) to disable slider while
-- touch is on
local function sliderListener(event)
    if touch == false then
        if event.target.id == 'head' then
            if event.target.value <= 25 then
                anim:setFrame(1)
            elseif event.target.value <= 50 then
                anim:setFrame(2)
            elseif event.target.value <= 75 then
                anim:setFrame(3)
            else
                anim:setFrame(4)
            end
            head_value = event.target.value
        elseif event.target.id == 'caudal_fin' then
            if event.target.value <= 20 then
                anim7:setFrame(1)
            elseif event.target.value <= 40 then
                anim7:setFrame(2)
            elseif event.target.value <= 60 then
                anim7:setFrame(3)
            elseif event.target.value <= 80 then
                anim7:setFrame(4)
            else
                anim7:setFrame(5)
            end
            caudal_value = event.target.value
        elseif event.target.id == 'pelvic_fin' then
            if event.target.value <= 33 then
                anim4:setFrame(1)
            elseif event.target.value <= 66 then
                anim4:setFrame(2)
            else
                anim4:setFrame(3)
            end
            pelvic_value = event.target.value
        elseif event.target.id == 'anal_fin' then
            if event.target.value <= 50 then
                anim5:setFrame(1)
            else
                anim5:setFrame(2)
            end
            anal_value = event.target.value
        elseif event.target.id == 'soft_ray' then
            if event.target.value <= 33 then
                anim6:setFrame(1)
            elseif event.target.value <= 66 then
                anim6:setFrame(2)
            else
                anim6:setFrame(3)
            end
            soft_value = event.target.value
        elseif event.target.id == 'h_move' then
            group.x = event.target.value * 10
            h_value = event.target.value
        end
    else
        if event.target.id == 'head' then
            sliderHead:setValue(head_value)
        elseif event.target.id == 'caudal_fin' then
            sliderCaudal:setValue(caudal_value)
        elseif event.target.id == 'pelvic_fin' then
            sliderPelvic:setValue(pelvic_value)
        elseif event.target.id == 'anal_fin' then
            sliderAnal:setValue(anal_value)
        elseif event.target.id == 'soft_ray' then
            sliderSoft:setValue(soft_value)
        elseif event.target.id == 'h_move' then
            sliderH:setValue(h_value)
        end
    end
end

--again these variables are co-ordinate references for the 5 different slider components
-- which will be added later on
local sliderX = 700
local sliderY = 450
local space = 70
local spaceText = 12

--add "mouth" text here for mouth slider
local mouth = display.newText( "Mouth", sliderX - 120, sliderY + spaceText, native.systemFont, 40 )
mouth:setFillColor( 1, 1, 1 )
--initialized slider for head
sliderHead = widget.newSlider(
    {
        top = sliderY,
        left = sliderX,
        width = 400,
        value = head_value,  -- Start slider at 10% (optional)
        listener = sliderListener,
        id = 'head'
    }
)

--add "caudal fin" text here for caudal_fin slider
local caudal = display.newText( "Caudal fin", sliderX - 150, sliderY + space + 15, native.systemFont, 40 )
caudal:setFillColor( 1, 1, 1 )
--initialized slider for caudal fin
sliderCaudal = widget.newSlider(
    {
        top = sliderY+space,
        left = sliderX,
        width = 400,
        value = caudal_value,  -- Start slider at 10% (optional)
        listener = sliderListener,
        id = 'caudal_fin'
    }
)

--add "pelvic fin" text here for pelvic fin slider
local pelvic = display.newText( "Pelvic fin", sliderX - 140, sliderY + space * 2 + 18, native.systemFont, 40 )
pelvic:setFillColor( 1, 1, 1 )
--initialize slider for pelvic fin
sliderPelvic = widget.newSlider(
    {
        top = sliderY + 2 * space,
        left = sliderX,
        width = 400,
        value = pelvic_value,  -- Start slider at 10% (optional)
        listener = sliderListener,
        id = 'pelvic_fin'
    }
)

--add "anal fin" text here for anal fin slider
local anal = display.newText( "Anal fin", sliderX - 130, sliderY + space * 3 + 21, native.systemFont, 40 )
anal:setFillColor( 1, 1, 1 )
--initialize slider for anal fin
sliderAnal = widget.newSlider(
    {
        top = sliderY + 3 * space,
        left = sliderX,
        width = 400,
        value = anal_value,  -- Start slider at 10% (optional)
        listener = sliderListener,
        id = 'anal_fin'
    }
)

--add "soft ray" text here for soft ray slider
local soft = display.newText( "Soft ray", sliderX - 130, sliderY + space * 4 + 24, native.systemFont, 40 )
soft:setFillColor( 1, 1, 1 )
--initialize slider for soft ray
sliderSoft = widget.newSlider(
    {
        top = sliderY + 4 * space,
        left = sliderX,
        width = 400,
        value = soft_value,  -- Start slider at 10% (optional)
        listener = sliderListener,
        id = 'soft_ray'
    }
)

--add "h.move" text for h.move slider
local move = display.newText( "H.move", sliderX - 140, sliderY + space * 5 + 27, native.systemFont, 40 )
move:setFillColor( 1, 1, 1 )
--initialize slider for h move
sliderH = widget.newSlider(
    {
        top = sliderY + 5 * space,
        left = sliderX,
        width = 400,
        value = h_value,  -- Start slider at 10% (optional)
        listener = sliderListener,
        id = 'h_move'
    }
)

--this variable is basically used for making the fish move up or down
--keeps track of whether down was previously true or not
local down = false

--this function makes the fish move up or down
--if down was previously false then we move down
--if down was previously true then we move up
local update = function(event)
    if(down == false) then
        transition.to(group, {time = 100, y=10})
        down = true
    else
        transition.to(group, {time=200, y = 0})
        down = false
    end
end

--again timer for the fish body that move up and down
--is triggered every 100ms
timer.performWithDelay(100, update, 0)