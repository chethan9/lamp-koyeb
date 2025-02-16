FROM ubuntu:20.04

# Install required dependencies
RUN apt-get update && apt-get install -y \
    wget libaio1 libncurses5 x11vnc xvfb fluxbox \
    && apt-get clean

# Download and install AMPPS
RUN wget -O /tmp/ampps.run http://www.ampps.com/downloads/AMPPS-3.9-linux-x86_64.run && \
    chmod +x /tmp/ampps.run && \
    /tmp/ampps.run --mode unattended && \
    rm /tmp/ampps.run

# Set environment variables
ENV PATH="/usr/local/ampps/bin:$PATH"

# Expose necessary ports (Apache, MySQL, and VNC)
EXPOSE 80 3306 5900

# Start AMPPS and VNC server
CMD x11vnc -forever -usepw -create && \
    /usr/local/ampps/Ampps && \
    tail -f /dev/null
