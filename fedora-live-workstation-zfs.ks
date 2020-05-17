%include fedora-live-workstation.ks

repo --name=zfs --baseurl=http://download.zfsonlinux.org/fedora/$releasever/$basearch/

%packages
kernel-devel
zfs
neovim
tmux
%end
