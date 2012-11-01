#Controls your camera, takes several photos continuously and saves it to computer disk rather than SD card.
#(Go to directory where you want the images to be saved)
gphoto2 --auto-detect --force-overwrite --capture-image-and-download --frames 3 --interval 10 --filename "%Y%m%d%H%M%S.jpg"

