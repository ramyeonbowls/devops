# ============================================================
# Dockerfile — LogPulse Dev Container
# Base: Ubuntu 24.04 (semua tools tersedia)
# Includes: Node 22, Go 1.25, common dev tools
# ============================================================

FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# ── System packages lengkap ───────────────────────────────
RUN apt-get update && apt-get install -y \
    # Shell & core utils
    bash \
    curl \
    wget \
    git \
    unzip \
    zip \
    ca-certificates \
    gnupg \
    # Build tools
    gcc \
    g++ \
    make \
    libc6-dev \
    # Text & process utils
    sed \
    gawk \
    grep \
    procps \
    jq \
    less \
    vim \
    # SQLite CLI
    sqlite3 \
    # Network tools
    iputils-ping \
    net-tools \
    # Misc
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# ── Node.js 22 via NodeSource ─────────────────────────────
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# ── Go 1.25 ───────────────────────────────────────────────
ARG GO_VERSION=1.25.3
RUN curl -fsSL "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" \
    -o /tmp/go.tar.gz \
    && tar -C /usr/local -xzf /tmp/go.tar.gz \
    && rm /tmp/go.tar.gz

ENV PATH="/usr/local/go/bin:/root/go/bin:${PATH}"
ENV GOPATH="/root/go"

# ── Go dev tools ──────────────────────────────────────────
RUN go install golang.org/x/tools/cmd/goimports@latest \
    && go install github.com/air-verse/air@latest

# ── Global Node tools ─────────────────────────────────────
RUN npm install -g tsx typescript

WORKDIR /workspace

CMD ["bash"]
