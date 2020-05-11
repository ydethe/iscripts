#! /bin/sh

rsync -mvP --exclude '*.DS_Store*' --exclude '@ea*' --chmod=Du=rwx,Dg=rwx,Do=rwx,Fu=rw,Fg=rw,Fo=rw $HOME/Music/iTunes/iTunes\ Media/Music/ eru:/volume1/music/ 


