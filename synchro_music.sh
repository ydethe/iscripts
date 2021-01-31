#! /bin/sh

rsync -rmvP --exclude '.DS_Store' --exclude '@ea*' --chmod=Du=rwx,Dg=rwx,Do=rwx,Fu=rw,Fg=rw,Fo=rw $HOME/Music/iTunes/iTunes\ Media/Music/ eru:/volume1/music/ 
# rsync -mvP --exclude '*.DS_Store*' --exclude '@ea*' --chmod=Du=rwx,Dg=rwx,Do=rwx,Fu=rw,Fg=rw,Fo=rw $HOME/Music/iTunes/iTunes\ Media/Music/ ks:/home/user-data/owncloud/yann\@johncloud.fr/files/Musique/
