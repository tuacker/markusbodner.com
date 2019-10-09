#!/bin/bash

cd "./content/gallery"

exiftool -all= *.gif *.jpg *.png *.jpeg
exiftool -delete_original! *.gif *.jpg *.png *.jpeg

exit
