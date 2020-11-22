Machine Learning in Docker.
===

Description : Do ML stuffs in docker and scripts for building src in docker.

currently supported:
   * tensorflow==2.5.0
   * opencv==4.5.0

---
### Intended for one who are in hurry
```
$ docker pull minlaxz/ml-devel:TAG
```
for interactive start. (this will auto remove container on exits, so that any changes will be discarded.)
```
$ docker run --rm -it --gpus all --device /dev/video0:/dev/video0 -v $HOME:$HOME \
-v /tmp/.X11-unix:/tmp/.X11-unix --ipc=host -e DISPLAY=$DISPLAY \
-p 8888:8888 minlaxz/ml-devel:TAG bash
```
if you want to make some changes (example install lib) try detach start.
```
$ docker run --name NAME -dt --gpus all --device /dev/video0:/dev/video0 \
-v $HOME:$HOME -v /tmp/.X11-unix:/tmp/.X11-unix --ipc=host -e DISPLAY=$DISPLAY \
-p 8888:8888 minlaxz/ml-devel:TAG

$ docker exec -it NAME bash # for interactive.

$ docker stop NAME
$ docker start NAME
```

If you want to use host's Xserver from docker,
```
host:~$ xhost + # access control disabled, clients can connect from any host
```
---

### Intended for one who has and know _Docker_
+ download from https://github.com/minlaxz/ml-in-docker/releases
+ unzip or untar && change dir
+ $ docker build -t NAME -f Dockerfile.TF .
+ $ docker run --args ...


> you can update, upgrade, or do whatever the fk you want to.
