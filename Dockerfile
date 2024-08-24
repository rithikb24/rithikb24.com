FROM ghcr.io/getzola/zola:v0.19.1 as zola

COPY . /project
WORKDIR /project
RUN ["zola", "build"]
