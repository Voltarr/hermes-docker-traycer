#!/usr/bin/env bash
set -e

echo "=========================================================="
echo "  AgentJail: Hermes Docker Sandbox Bridge for macOS & Traycer"
echo "=========================================================="
echo ""

# 1. Check Docker running
if ! docker info >/dev/null 2>&1; then
    echo "❌ Error: Docker Desktop is not running. Please start Docker Desktop first."
    exit 1
fi
echo "✓ Docker Desktop is running"

# 2. Setup wrapper in ~/bin
mkdir -p "$HOME/bin"
cp hermes-docker "$HOME/bin/hermes-docker"
chmod 755 "$HOME/bin/hermes-docker"
echo "✓ Installed bridge wrapper to $HOME/bin/hermes-docker"

# 3. Setup host credential link
if [ -d "$HOME/.hermes-docker" ] && [ ! -e "$HOME/.hermes" ]; then
    ln -s "$HOME/.hermes-docker" "$HOME/.hermes"
    echo "✓ Linked ~/.hermes -> ~/.hermes-docker"
fi

# 4. Patch container runtime discovery & cwd translation if container is up
if docker ps --format '{{.Names}}' | grep -q 'hermes-sandbox'; then
    echo "✓ Container hermes-sandbox detected"
    
    # Patch discovery permissions for virtiofs
    docker exec hermes-sandbox python3 -c '
path = "/opt/hermes/hermes_cli/gateway_runtime_discovery.py"
try:
    with open(path, "r") as f: content = f.read()
    old = "    if not home and mode & 0o077:\n        raise _open_mode(path, mode, 0o700 if kind == \"directory\" else 0o600)"
    new = "    if not home and mode & 0o077:\n        pass  # Docker Desktop virtiofs fakeowner compatibility"
    if old in content:
        with open(path, "w") as f: f.write(content.replace(old, new))
        print("  ✓ Patched gateway_runtime_discovery.py for virtiofs")
except Exception as e:
    print("  Notice: runtime discovery patch skipped or already present")
'

    # Patch session cwd translation
    docker exec hermes-sandbox python3 -c '
path = "/opt/hermes/acp_adapter/session.py"
try:
    with open(path, "r") as f: content = f.read()
    if "map macOS host workspace paths" not in content:
        old = "    return translate_cwd_for_wsl_backend(str(cwd))"
        new = """    translated = translate_cwd_for_wsl_backend(str(cwd))
    if os.path.isdir(translated): return translated
    if str(translated).startswith("/Users/openclaw/.openclaw/workspace"):
        rel = os.path.relpath(translated, "/Users/openclaw/.openclaw/workspace")
        cand = os.path.join("/workspace", rel) if rel != "." else "/workspace"
        if os.path.isdir(cand): return cand
    if os.path.isdir("/workspace"): return "/workspace"
    if os.path.isdir("/opt/data"): return "/opt/data"
    return "/""""
        with open(path, "w") as f: f.write(content.replace(old, new))
        print("  ✓ Patched session.py for macOS path translation")
except Exception as e:
    print("  Notice: session cwd patch skipped or already present")
'
fi

# 5. Bounce traycer-host if running
if pgrep -f traycer-host >/dev/null 2>&1; then
    killall traycer-host 2>/dev/null || true
    echo "✓ Bounced traycer-host to clear cache"
fi

echo ""
echo "=========================================================="
echo "🎉 Setup Complete!"
echo "In Traycer: Settings -> Providers -> Hermes Agent -> Add custom path:"
echo "  $HOME/bin/hermes-docker"
echo "=========================================================="
