# fedora-livecd-xfce.ks
#
# Description:
# - Fedora Live Spin with the light-weight XFCE Desktop Environment
#
# Maintainer(s):
# - Rahul Sundaram    <sundaram@fedoraproject.org>
# - Christoph Wickert <chris@christoph-wickert.de>
# - Kevin Fenzi       <kevin@tummy.com>
# - Adam Miller       <maxamillion@gmail.com>

%include fedora-live-base.ks

%packages

firefox
NetworkManager-vpnc
NetworkManager-openvpn
NetworkManager-gnome
NetworkManager-pptp

gparted

# Add the midori browser as a lighter alternative
midori

cheese

# we don't include @office so that we don't get OOo.  but some nice bits
abiword
gnumeric

evince
-evince-dvi
-evince-djvu

gimp
inkscape

gcalctool
desktop-backgrounds-compat
gnome-screensaver
setroubleshoot

# development
geany

# More Desktop stuff
xdg-user-dirs
@java
totem
totem-mozplugin
pidgin
claws-mail
claws-mail-plugins-archive
claws-mail-plugins-att-remover
claws-mail-plugins-attachwarner
claws-mail-plugins-bogofilter
claws-mail-plugins-cachesaver
claws-mail-plugins-fetchinfo
claws-mail-plugins-mailmbox
claws-mail-plugins-newmail
claws-mail-plugins-notification
claws-mail-plugins-pgp
claws-mail-plugins-rssyl
claws-mail-plugins-smime
claws-mail-plugins-spam-report
claws-mail-plugins-tnef
claws-mail-plugins-vcalendar
xfburn
liferea
quodlibet
gftp
ristretto
asunder
catfish
catfish-engines
xfce4-power-manager
seahorse
rtorrent
transmission
cups-pdf
gnome-bluetooth
alsa-plugins-pulseaudio
pavucontrol

# Command line
ntfs-3g
powertop
wget
irssi
mutt
yum-utils

# xfce packages
@xfce-desktop
Terminal
gtk-xfce-engine
orage
thunar-volman
thunar-media-tags-plugin
gigolo
xarchiver
xfce4-battery-plugin
# we already have thunar-volman
#xfce4-cddrive-plugin
xfce4-cellmodem-plugin
xfce4-clipman-plugin
xfce4-cpugraph-plugin
xfce4-datetime-plugin
xfce4-dict-plugin
xfce4-diskperf-plugin
xfce4-eyes-plugin
xfce4-fsguard-plugin
xfce4-genmon-plugin
xfce4-mailwatch-plugin
xfce4-mount-plugin
xfce4-netload-plugin
xfce4-notes-plugin
xfce4-places-plugin
xfce4-quicklauncher-plugin
xfce4-smartbookmark-plugin
xfce4-screenshooter-plugin
xfce4-sensors-plugin
xfce4-systemload-plugin
xfce4-taskmanager
xfce4-time-out-plugin
xfce4-timer-plugin
xfce4-verve-plugin
xfce4-volstatus-icon
# we already have nm-applet
#xfce4-wavelan-plugin
xfce4-weather-plugin
xfce4-websearch-plugin
# this one a compatibility layer for GNOME applets and depends on it
#xfce4-xfapplet-plugin
xfce4-xkb-plugin
xfwm4-themes

# dictionaries are big
#-aspell-*
#-man-pages-*

# more fun with space saving
-gimp-help


# save some space
-autofs
-nss_db
-sendmail
ssmtp
-acpid
# system-config-printer does printer management better
# xfprint has now been made as optional in comps.
system-config-printer
%end

%post
# xfce configuration

# create /etc/sysconfig/desktop (needed for installation)

cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/startxfce4
EOF

mkdir -p /home/liveuser/.config/xfce4

cat > /home/liveuser/.config/xfce4/helpers.rc <<EOF
MailReader=sylpheed-claws
EOF

mkdir -p /root/.config/xfce4

cat > /root/.config/xfce4/helpers.rc <<EOF
MailReader=sylpheed-claws
EOF

cat >> /etc/rc.d/init.d/livesys << EOF
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

# disable screensaver locking
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/gnome-screensaver/lock_enabled false >/dev/null
# set up timed auto-login for after 60 seconds
cat >> /etc/gdm/custom.conf << FOE
[daemon]
TimedLoginEnable=true
TimedLogin=liveuser
TimedLoginDelay=60
FOE

EOF

%end

