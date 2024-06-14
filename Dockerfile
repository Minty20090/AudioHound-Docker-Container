# Use a base image with Ubuntu
FROM ubuntu:22.04

# Install dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y \
    wget \
    unzip \
    libusb-1.0-0-dev \
    libpython3.10 \
    sudo \
    ffmpeg \
    libsm6 \
    libxext6 \
    libgl1 \
    desktop-file-utils \
    libgl1-mesa-glx \
    libxcb-xinerama0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-render-util0 \
    libxcb-randr0 \
    libxcb-shape0 \
    libxcb-xkb1 \
    libxkbcommon-x11-0 \
    file \
    desktop-file-utils \
    x11-apps \
    x11-xserver-utils \
    libglu1-mesa \
    libgl1-mesa-dri \
    usbutils \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -ms /bin/bash signalhound
RUN adduser signalhound sudo
RUN echo 'signalhound ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER signalhound
WORKDIR /home/signalhound

# Download and install Signal Hound API and software
RUN wget https://signalhound.com/sigdownloads/Spike/Spike\(Ubuntu22.04x64\)_3_9_6.zip \
    && unzip Spike\(Ubuntu22.04x64\)_3_9_6.zip \
    && sudo mkdir -p /etc/udev/rules.d/ \
    && cd Spike\(Ubuntu22.04x64\)_3_9_6 \
    && sudo chmod +x setup.sh \
    && sudo ./setup.sh \
    && file ./lib/libsm_api.so.2

# Set environment variables for Qt
ENV QT_XCB_GL_INTEGRATION=none
ENV QT_PLUGIN_PATH=/home/signalhound/Spike\(Ubuntu22.04x64\)_3_9_6/plugins
ENV LIBGL_ALWAYS_INDIRECT=1


# Expose necessary ports (if any)
EXPOSE 8080

# Set entrypoint
ENTRYPOINT ["/bin/bash"]
