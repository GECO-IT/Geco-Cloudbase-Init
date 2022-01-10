# Geco-cloudbase-init
This is a Proxmox patch that allows us to use Cloudbase-init with windows hosts.

What can you do with this patch?
Use Cloudbase-Init with Windows VMs to:
* Create a new user with username or enable administrator.
* Set a password on the new user or administrator.
* Set static ip or dhcp on network adapters.
* Set machine hostname.
* Insert public ssh keys to "user/.ssh/authorized_keys" file of created/enabled user.
* Expand partition volumes automatically when there's a resized disk.

You can do all below on system startup with the data provided by the cloud-init section of the proxmox gui.


There is two files that we need to modify Qemu.pm and Cloudinit.pm.
* Qemu.pm to get password as cleartext in meta_data drive when it is a Windows VM.
* Cloudinit.pm to generate a metadata json file with variables that are compatible with Cloudbase-Init.


