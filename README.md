# kazu-robo_tools

## frame_cutter.sh
You can cut out frames from video file by specified fps and cropping area.

### needed package
You need to install `ffmpeg`.

`$ sudo apt install ffmpeg`

### usage
`$ ./frame_cutter.sh`

`input the file name : (INPUT YOUR VIDEO FILE NAME)`

***
#### NOTE FOR ERROR
If your video file is shorter than 1 second, error below might occurs.

`Output file is empty, nothing was encoded (check -ss / -t / -frames parameters if used)`

In this case, you should change line 8 of frame_cutter.sh (which is the first ffmpeg command in the file).

If you set fps argument larger enough, this error would be fixed.
***

Now you can see the image of parameters you set for cropping, and also for the size of the input images.

Look at that and enter each parameters like below.
```
width (pixel) : (CROPPING WIDTH)
height (pixel) : (CROPPING HEIGHT)
x of the upper left corner (pixel) : (x COMPONENT OF CROPPING AREA'S　UPPER LEFT CORNER)
y of the upper left corner (pixel) : (y COMPONENT OF CROPPING AREA'S　UPPER LEFT CORNER)
```
Now you can see the cropped area example.

If cropping area is ok with that, enter y. If not, enter n and set parameters again.

Then, you can set fps, output file name, starting second of cutting out, and time length of cutting out.
```
fps (frame per second) : (FPS you want to cut out)
output file name : (OUTPUT FILE NAME)
start second [sec]: (STARTING TIME)
time length of cutting out [sec]: (TIME LENGTH)
```
Finally, you get directory of your entered output file name, and cut out images are under there.
