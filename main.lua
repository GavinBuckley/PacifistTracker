meta.name = "Pacifist Tracker"
meta.version = "1.0"
meta.description = "Made for DougDoug's Pacifist playthrough."
meta.author = "litttlehawk"

white = Color:white()
black = Color:black()
internalkills = 0
text_alpha = .5
box_alpha = 0
last_ms = 0 
timer = 0
start = 1
dead = 1
deathquipid = 0

register_option_bool('deathquips', 'Display quips on the death screen?', true)
register_option_bool('killonkill', 'Does killing an enemy kill the player? (Activates on next attempt)', false)

-- Checks to see if player is paused or transistioning screens
function show()

  for i, v in ipairs(players) do

    if state.screen == ON.TRANSITION or state.pause ~= 0 then

      return false

    end

    if testflag(state.level_flags, 22) then

      return false

    end

  end

  return true

end

-- Draws and updates the kill count, icon, and text
set_callback(function(render_ctx)

    if show() and dead == 0 then

        -- Makes the kill counter turn invisible after a period of time
        if players[1].inventory.kills_total > internalkills or start == 1 then

            last_ms = get_ms()
            timer = 1
            text_alpha = 1 
            box_alpha = 1
            internalkills = players[1].inventory.kills_total

            if start == 1 then

                start = 0

            end

        end


        if get_ms() - last_ms >= 3500 then

            if timer >= .5 then

                box_alpha = box_alpha - .02
                text_alpha = text_alpha - .01
                timer = timer - .01

            end

        end

        -- Draw box for kill count
        render_ctx:draw_screen_texture(TEXTURE.DATA_TEXTURES_HUD_0, 0, 4, .1675, 0.925, .2575 , 0.785, Color:new(1,1,1,box_alpha))
        render_ctx:draw_screen_texture(TEXTURE.DATA_TEXTURES_HUD_0, 0, 5, .2575, 0.925, .3275 , 0.785, Color:new(1,1,1,box_alpha))
        render_ctx:draw_screen_texture(TEXTURE.DATA_TEXTURES_HUD_0, 0, 6, .3275, 0.925, .4175 , 0.785, Color:new(1,1,1,box_alpha))

        -- Draw skull icon
        render_ctx:draw_screen_texture(TEXTURE.DATA_TEXTURES_HUD_0, 1, 7, .13, 0.927, .22 , 0.786, white)

        -- Draw kill count
        render_ctx:draw_text(F'{players[1].inventory.kills_total}', 0.22, .856, 0.0006, 0.0006, Color:new(1,1,1,text_alpha), VANILLA_TEXT_ALIGNMENT.LEFT, VANILLA_FONT_STYLE.BOLD)

    end

end, ON.RENDER_POST_HUD)

-- Kill player on enemy kill if option is enabled
set_callback(function()

    for i,player in ipairs(players) do

        if player.inventory.kills_total > 0 and killforkill == true then

                kill_entity(player.uid)

                dead = 1

        end

    end

end, ON.RENDER_POST_HUD)

-- Tells the game that you're not dead on the first frame of the level and the code can begin running
function notdead()

    dead = 0

end

-- Resets all the variables everytime the game starts or is reset
function reset()

    killforkill = options.killonkill
    internalkills = 0
    start = 1 

end

-- Draws quips on the death screen if option is enabled
set_callback(function(render_ctx, page_type, page)

    deathquip = options.deathquips

    if deathquip == true and dead == 1 then

        if page_type == JOURNAL_PAGE_TYPE.DEATH_CAUSE then

            render_ctx:draw_text(death_quips[deathquipid], 0.25, -0.65, 0.0016, 0.0009, black, VANILLA_TEXT_ALIGNMENT.CENTER, VANILLA_FONT_STYLE.ITALIC)
    
        end

    end

end, ON.RENDER_POST_JOURNAL_PAGE)

-- Generates a random quip on death
set_callback(function()

    deathquipid = math.random(1,3) -- Increase the max number depending on how many quips there are
    dead = 1

end, ON.DEATH)

death_quips = {

    "Sorry Believers.",
    "RIGGED",
    "Another win for the Doubters.",

}

set_callback(notdead, ON.LEVEL)
set_callback(reset, ON.START)
set_callback(reset, ON.RESET)