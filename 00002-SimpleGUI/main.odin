package main

// Importing required packages
// ----------------------------------------------------------------------------------------------------
import		"core:fmt";				// Basic formating and printing library
import		"core:math";				// Basic math library
import	alg	"core:math/linalg";			// Linear algebra module from math library module
import	rl	"vendor:raylib";			// Simple graphics library


main :: proc () {
	// Defining constatns
	// ----------------------------------------------------------------------------------------------------
	// Window settings
	SCREEN_WIDTH, SCREEN_HEIGHT :: 1920, 1080;
	TARGET_FPS :: 60;
	
	// Tower model settings
	modelPosition	:     = rl.Vector3{0.0, 7.5, 0.0};
	modelTintColor	:     = rl.RAYWHITE;
	modelScale	:     = rl.Vector3{1.0, 1.0, 1.0};
	

	// Window setup
	// ----------------------------------------------------------------------------------------------------
	rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "tower");		// Initializing the window
	defer rl.CloseWindow();						// Closing the window at the end
	rl.SetTargetFPS(TARGET_FPS);					// setting a limit on the FPS to not overload the GPU


	// Loading assets
	// ----------------------------------------------------------------------------------------------------
	model		:     = rl.LoadModel(`./assets/meshes/mideval tower/tower.glb`);
	
	
	// Releasing assets
	// ----------------------------------------------------------------------------------------------------
	defer rl.UnloadModel(model);
	
	
	
	// Setting up the camera
	// ----------------------------------------------------------------------------------------------------
	camera : rl.Camera3D	= {};
	camera.position		= rl.Vector3{6.0, 6.0, 6.0};
	camera.target		= rl.Vector3{0.0, 1.0, 0.0};
	camera.up		= rl.Vector3{0.0, 1.0, 0.0};
	camera.fovy		= 60.0;
	camera.projection	= .PERSPECTIVE;
	
	
	// Main Loop
	// ----------------------------------------------------------------------------------------------------
	for !rl.WindowShouldClose() { 
		// Updtaing Camera
		// ----------------------------------------------------------------------------------------------------
		rl.UpdateCamera(&camera, .ORBITAL);
		
		
		// Starting the drawing mode
		// ----------------------------------------------------------------------------------------------------
		rl.BeginDrawing();
		
		
		// Clearing  the background
		// ----------------------------------------------------------------------------------------------------
		rl.ClearBackground(rl.RAYWHITE);
		
		
		// Starting 3D Mode
		// ----------------------------------------------------------------------------------------------------
		rl.BeginMode3D(camera);
		
		
		// Drawing 3D assets
		// ----------------------------------------------------------------------------------------------------
		rl.DrawPlane({0.0, 0.0, 0.0}, {100, 100}, {70, 70, 90, 255});
		rl.DrawGrid(100, 0.2);
		rl.DrawModelEx(model, modelPosition, {1.0, 0.0, 0.0}, -90, modelScale, modelTintColor)
		
		
		// Ending 3D mode
		// ----------------------------------------------------------------------------------------------------
		rl.EndMode3D();
		
		
		// Ending drawing mode
		// ----------------------------------------------------------------------------------------------------
		rl.EndDrawing();
	}
	
}
