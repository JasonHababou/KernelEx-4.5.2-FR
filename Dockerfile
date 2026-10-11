FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends binutils-mingw-w64-i686 gcc-mingw-w64-i686 g++-mingw-w64-i686 make python3 ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /work
# Exemple: i686-w64-mingw32-windres -I source/verify -O coff -o verify-fr.o verify-fr.rc
