# Use an official PyTorch image built with CUDA 11.3 and cuDNN8
FROM pytorch/pytorch:1.12.1-cuda11.3-cudnn8-runtime

LABEL maintainer="Shaun Song <song.1634@osu.edu>"

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_DRIVER_CAPABILITIES=all
ENV MESA_GL_VERSION_OVERRIDE=4.5
ENV MESA_GLSL_VERSION_OVERRIDE=450

# Copy the entire project into /workspace and set as work directory
COPY . /workspace
WORKDIR /workspace

# Run your setup script (which installs dependencies, builds tools, etc.)
RUN bash setup_tools.sh

# Configure runtime environment variables for your project
ENV main_path="/workspace"
ENV PYTHON_LIBDIR="/opt/conda/lib"
ENV PATH="$main_path/tools/bin/OpenMVS:$main_path/tools/bin:$PATH"
ENV LD_LIBRARY_PATH="$main_path/tools/lib/OpenMVS:$main_path/tools/lib:$PYTHON_LIBDIR:$LD_LIBRARY_PATH"
ENV PYTHONPATH="$main:$main_path/tools/lib"