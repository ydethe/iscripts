#! /bin/sh

# rsync -rmvP --exclude '.DS_Store' --exclude '@ea*' --chmod=Du=rwx,Dg=rwx,Do=rwx,Fu=rw,Fg=rw,Fo=rw $HOME/Music/iTunes/iTunes\ Media/Music/. eru:/volume1/music
# rsync -mvP --exclude '*.DS_Store*' --exclude '@ea*' --chmod=Du=rwx,Dg=rwx,Do=rwx,Fu=rw,Fg=rw,Fo=rw $HOME/Music/iTunes/iTunes\ Media/Music/ ks:/home/user-data/owncloud/yann\@johncloud.fr/files/Musique/
rsync -avz --exclude '.DS_Store' --exclude '@ea*' --no-perms --no-owner --no-group --ignore-existing --omit-dir-times /Users/ydethe/Music/Music/Media.localized/Music/ johncloud:johncloud_data/nextcloud/data/data/ydethe/files/Musique
