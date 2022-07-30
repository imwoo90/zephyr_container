# About
Easy Start Zephyr application using docker
# Requires
* docker (you must add group for no sudo)
* docker-compose
* vscode (extension id)
    * ms-vscode-remote.vscode-remote-extensionpack
    * ms-azuretools.vscode-docker
# Getting Started
If you are ready above the requires, press F1 key and enter keyword 'reopen' 

so you can see 'Remote Containers: Reopen in container'

Just click!

![reopen](./doc/reopen.png)

# Notice
On linux, it may very slow that build environment is ready

because uid,gid of user inside the docker image changes 

to uid,gid of host
(uid and gid of user inside the docker image is each 1000)
