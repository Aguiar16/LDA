FROM r-base:latest
# Set working directory to /app
WORKDIR /LDA
# Copy local contents into container
ADD . /LDA
# Install all required depedencies
RUN apt-get update && apt-get install libxml2-dev libgsl-dev -y && Rscript build.R
CMD ["Rscript", "optimizedLDA.R"]
