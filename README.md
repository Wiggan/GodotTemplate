# Godot Template

This is a small template project for Godot 4.1 that I've been using for some game jams.
It was made with 3d games with hidden cursor (fps/3rd person) in mind.
The menu is a bit annoying to work with at the moment.

## Shader caching

A thing that causes stuttering in a godot game is when a shader is first used in a scene.
Therefore, all draw passes and such that are used in particle systems that are not visible from the start could be put in the folder called "draw_passes" and they will be instantiated on the first frame and the deleted on the second frame, to some extent avoiding this kind of stutter.

## Leaderboard

There is an implementation for a http://dreamlo.com/ leaderboard. Go there and get your own if you want to use that feature.