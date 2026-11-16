Simple video player I made in Ruby.
Enter the local path of an mp4 video file and
it will play them using ASCII characters.

What it does is it extract the audio of the 
video to play in the background, then it extracts 
each one of the frames, scales them down, converts
them to grayscale, maps each pixel's brightness
to a character in a gradient made of ASCII, and 
renders them in the terminal at 24 frames per 
second.

This idea came to me as I was making Bad Apple in
Ruby. This should essentially work with any mp4 file
but the worse the resolution, the better the framerate.

<video src="./demo.mp4" width="600" controls>
  Your viewer does not support video playback. Watch it at: ./demo.mp4
</video>
