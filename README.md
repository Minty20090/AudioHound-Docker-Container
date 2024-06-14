# AudioHound-Docker-Container
Docker Container to run AudioHound on MacOS
### **1. Set Up X11 Forwarding**

1. Install XQuartz: 
    1. [XQuartz.org](https://www.xquartz.org/).
    2. Also run this command
    
    ```python
    brew install --cask xquartz
    ```
    
2. Setup XQuartz: 
    1. Launch XQuartz on your Mac. Go to Applications > Utilities > XQuartz > XQuartz Settings > Security and ensure "Allow connections from network clients" is checked.
3. Configure XQuartz to Allow Connections: In the terminal on your Mac, allow connections from your Docker container:

```python
xhost + 127.0.0.1
xhost +$(hostname)
export DISPLAY=:0
```

1. Restart your computer… yes ik its annoying

### 2. Set up Docker Container

1. **Download the docker file:** 
    1. GitHub
2. **Build the Docker Image:** Open a terminal, navigate to the directory containing your Dockerfile, pull the Ubuntu OS, and build the Docker image:

```python
Docker pull ubuntu
docker build -t signalhound-container .
```

1. **Run the Docker Container with Display Environment Variable**: You need to pass the display environment variable to the Docker container and mount the X11 socket. Use the following Docker run command:

```python
docker run -it --rm --privileged \
  -e DISPLAY=host.docker.internal:0 \
  -e LIBGL_ALWAYS_INDIRECT=1 \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /dev/bus/usb:/dev/bus/usb \
  signalhound-container
```

1. **Open the terminal in Docker:** Click on the 3 dots next to the running container and click open in terminal. Switch directories into the Spike folder and run Spike

```python
cd Spike\(Ubuntu22.04x64\)_3_9_6
```

```python
./Spike
```

1. If it still doesn’t work, restart your computer again and try building + running the container again
