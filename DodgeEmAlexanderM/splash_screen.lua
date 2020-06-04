-----------------------------------------------------------------------------------------
--Alexander M
--This program is an animation for my company logo
-----------------------------------------------------------------------------------------
-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local circle
local text
local tree
local scrollSpeed = 5
--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------
--The fuction that makes th circle appear
local function visibleCircle()
    circle.alpha = circle.alpha + 0.005
end

-- The functions that moves the tree and text across the screen
local function moveTree()
    if (tree.x > display.contentWidth/2) then
        tree.x = tree.x - scrollSpeed
    else
        tree.x = display.contentWidth/2
    end
end

local function moveText()
    if (text.x < display.contentWidth/2) then
        text.x = text.x + scrollSpeed
    else
        text.x = display.contentWidth/2
        visibleCircle()
    end
end

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "Main_Menu", {effect = "fade", time = 1000})
end
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background to be black
    display.setDefault("background", 0, 0, 0)

    -- Insert the tree image
    tree = display.newImageRect("Images/alex photoshop 3.png", 400, 400)
    -- Insert the text image
    text = display.newImageRect("Images/alex photoshop 2.png", 400, 250)
    --Insert the circle
    circle = display.newImageRect("Images/alex photoshop 1.png", 400, 400)

    -- set the initial x and y position of the tree
    tree.x = display.contentWidth
    tree.y = display.contentHeight/2

    -- set the initial x and y position of the text
    text.x = display.contentWidth/10000
    text.y = display.contentHeight/2
    -- set the initial x and y position of the circle
    circle.x = display.contentWidth/2
    circle.y = display.contentHeight/2 + 25
    circle:toBack()
    circle.alpha = 0

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( tree )
    sceneGroup:insert( text )
    sceneGroup:insert( circle )
end

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        --play sound
        local music = audio.loadStream( "Sounds/IntroMusic0.mp3")
        local musicChannel = audio.play( music, { channel = 1, loops = -1})

        -- Call the moveTree function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", moveTree)
        --Call the moveText function
        Runtime:addEventListener("enterFrame", moveText)

        -- Go to the main menu screen after a given time.
        timer.performWithDelay ( 3000, gotoMainMenu)        
    end  
end
-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    if ( phase == "will" ) then
        --stop the music
        music = audio.fadeOut()

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene