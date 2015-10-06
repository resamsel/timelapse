# Timelapse Script

Creates a timelapse image and/or video of the given picture series.

## Shoot Pictures

Create lots of images of the night sky, using a tripod and long exposure

### Short Tutorial

From http://www.thephotoforum.com/threads/star-trails-time-lapse.298695/

- use tungsten white balance
- at least three 30 second exposures with no more than 2 seconds in between shots
- turn off noise reduction
- turn off vibration reduction
- 200-600 ISO
- don't use AF-continuous focus: use servo AF and AE (auto exposure) lock
- aperture f/4 (f/8 - f/11 in a light polluted, urban area)

## Process Pictures

Change into the directory where the photographed images lie, i.e.

```
$ cd path/to/timelapse/source
$ ls -1
img_0023.jpg
img_0024.jpg
img_0025.jpg
img_0026.jpg
img_0027.jpg
```

Run make image or make video or both

```
$ make image video
```

The files timelapse.png and timelapse.mp4 will be created.

## Configuration

Use several parameters to control the output:

### Name

The base name of the target files.

NAME=timelapse

### Prefix

The prefix of the source images.

PREFIX=img_

### Suffix

The suffix of the source images.

SUFFIX=jpg

### FPS

The number of frames per second of the target video.

FPS=25

### In Format

The format of the image file names. It will be prefixed and suffixed with the PREFIX and SUFFIX, respectively.

INFORMAT=%03d

### Image Suffix

The image container.

IMAGE_SUFFIX=png

### Video Suffix

The video container.

VIDEO_SUFFIX=mp4

### Example with Parameters

```
$ make image video NAME=my-timelapse
$ make image video NAME=my-timelapse FPS=30
```
