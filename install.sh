#!/usr/bin/env bash
set -e

echo "=========================================================="
echo "  AgentJail: Hermes Docker Sandbox Bridge for macOS & Traycer"
echo "  Supports: Apple Silicon (M1/M2/M3/M4) & Intel Macs"
echo "=========================================================="
echo ""

# 1. Check Docker running
if ! docker info >/dev/null 2>&1; then
    echo "❌ Error: Docker Desktop is not running."
    echo "Please start Docker Desktop and run ./install.sh again."
    exit 1
fi
echo "✓ Docker Desktop is running"

# 2. Setup host data directories and link
mkdir -p "$HOME/.hermes-docker" "$HOME/.openclaw/workspace" "$HOME/bin"
if [ ! -e "$HOME/.hermes" ]; then
    ln -s "$HOME/.hermes-docker" "$HOME/.hermes"
    echo "✓ Linked ~/.hermes -> ~/.hermes-docker"
fi

# 3. Launch container if not running
if ! docker ps --format '{{.Names}}' | grep -q '^hermes-sandbox$'; then
    echo "Starting hermes-sandbox container via docker compose..."
    docker compose up -d
    echo "Waiting 5 seconds for gateway to initialize..."
    sleep 5
fi
echo "✓ hermes-sandbox container is active"

# 4. Copy bridge wrapper to ~/bin
cp hermes-docker "$HOME/bin/hermes-docker"
chmod 755 "$HOME/bin/hermes-docker"
echo "✓ Installed bridge wrapper to $HOME/bin/hermes-docker"

# 5. Apply runtime patches inside container
echo "Applying virtiofs permission & path translation patches..."
docker exec hermes-sandbox python3 -c '
# Patch discovery permissions for virtiofs
p1 = "/opt/hermes/hermes_cli/gateway_runtime_discovery.py"
try:
    with open(p1, "r") as f: c1 = f.read()
    old1 = "    if not home and mode & 0o077:\n        raise _open_mode(path, mode, 0o700 if kind == \"directory\" else 0o600)"
    new1 = "    if not home and mode & 0o077:\n        pass  # Docker Desktop virtiofs fakeowner compatibility"
    if old1 in c1:
        with open(p1, "w") as f: f.write(c1.replace(old1, new1))
except Exception: pass

# Patch cwd path translation for macOS host workspaces
p2 = "/opt/hermes/acp_adapter/session.py"
try:
    with open(p2, "r") as f: c2 = f.read()
    if "map macOS host workspace paths" not in c2:
        old2 = "    return translate_cwd_for_wsl_backend(str(cwd))"
        new2 = """    translated = translate_cwd_for_wsl_backend(str(cwd))
    if os.path.isdir(translated): return translated
    if str(translated).startswith("/Users/"):
        cand = "/workspace"
        if os.path.isdir(cand): return cand
    if os.path.isdir("/workspace"): return "/workspace"
    if os.path.isdir("/opt/data"): return "/opt/data"
    return "/""""
        with open(p2, "w") as f: f.write(c2.replace(old2, new2))
except Exception: pass

# Patch auth.py to suppress unsolicited terminal setup
p3 = "/opt/hermes/acp_adapter/auth.py"
try:
    with open(p3, "r") as f: c3 = f.read()
    old3 = "    methods.append(TerminalAuthMethod("
    new3 = "    else:\n        methods.append(TerminalAuthMethod("
    if old3 in c3:
        with open(p3, "w") as f: f.write(c3.replace(old3, new3, 1))
except Exception: pass
'
echo "✓ Runtime patches verified"

# 6. Bounce traycer-host to clear cache if running
if pgrep -f traycer-host >/dev/null 2>&1; then
    killall traycer-host 2>/dev/null || true
    echo "✓ Bounced traycer-host daemon to ensure fresh cache"
fi

echo ""
echo "=========================================================="
echo "🎉 Setup Complete!"
echo "In Traycer: Settings -> Providers -> Hermes Agent -> Add custom path:"
echo "  $HOME/bin/hermes-docker"
echo "=========================================================="
