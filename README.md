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

If you want to apply the patch manually you can follow these steps: [Manual Patching](https://git.geco-it.net/c.soylu/Geco-cloudbase-init/src/branch/master/MANUALPATCH.md)

## Scripts
We have two scripts that do some fonctionality that we needed; enabling administrator user and enabling dhcp
You need to move those scripts into Cloudbase Solutions\Cloudbase-Init\LocalScripts\ in your program files.

## Powershell Script
This powershell script has a few uses.
* Deletes the "cloudbase-init" user, delegates "cloudbase-init" service to local Systeme user and modifies execution path of the script also to use local system user.
* Installs OpenSSH-Server from optional features of Windows.
* Removes a store language package that causes an error when generelazing for sysprep.

You need to run this script after installing Cloudbase-Init Continous Build. We need continous build to use Username fonctionality of openstack service.

When everythin is installed simply run below in powershell to launch sysprep:
```
cd ‘C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf’
C:\Windows\System32\sysprep\sysprep.exe /generalize /oobe /unattend:Unattend.xml

```

