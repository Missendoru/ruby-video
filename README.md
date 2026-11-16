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

https://github.com/user-attachments/assets/dcaa28f5-54f6-4bc7-80af-b6dbdb4257bd



