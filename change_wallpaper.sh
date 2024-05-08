#!/bin/bash

# Define wallpaper paths for each workspace
wallpapers=(
	"/home/dinesh/wallpaper/img1.jpg"
	"/home/dinesh/wallpaper/img1.jpg"
	"/home/dinesh/wallpaper/img2.jpg"
	"/home/dinesh/wallpaper/img3.jpg"
	"/home/dinesh/wallpaper/img4.jpg"
	"/home/dinesh/wallpaper/img5.jpg"
	"/home/dinesh/wallpaper/img6.jpg"
	"/home/dinesh/wallpaper/img8.jpg"
	"/home/dinesh/wallpaper/img6.jpg"
	"/home/dinesh/wallpaper/img8.jpg"
)

# Get the current workspace number
current_workspace=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).num')

# Set the wallpaper for the current workspace
feh --bg-fill "${wallpapers[$((current_workspace - 1))]}"
