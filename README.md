# AgentJail: Hermes Docker Sandbox Bridge for macOS & Traycer

> **Run Hermes Agent securely inside an isolated Docker container while driving it through Traycer on macOS — with zero permission errors, non-root security, and automatic Apple Silicon & Intel Mac support.**

[![Purchase Turnkey Bundle](https://img.shields.io/badge/Instant%20Download-Stripe%20%2419-blue?style=for-the-badge&logo=stripe)](https://buy.stripe.com/bJecMX5g1eAZ7lC2Jm5os00)

![Architecture Blueprint](assets/architecture.png)

---

## Why AgentJail Exists

Autonomous AI coding agents (Hermes, Claude Code, Codex) require terminal execution and filesystem privileges. Running them natively on macOS gives an autonomous LLM raw root-level access to your personal documents, SSH keys, passwords, and local network.

Running Hermes inside a Docker sandbox on macOS solves security, but historically triggered critical virtualization conflicts:
1. **The macOS virtiofs Socket Trap:** Docker Desktop on macOS locks AF_UNIX sockets to mode `0755` and rejects `chmod 600` with `EINVAL`. Hermes CLI discovery strictly required `0600`, crashing with `unsafe_control_permissions`.
2. **The Non-Root Privilege Boundary:** `docker exec` defaults to root (UID 0), while Hermes drops privileges to user `hermes` (UID 502), causing `unsafe_control_path` rejections.
3. **The Stdio vs. TTY Protocol Collision:** Traycer's Agent Client Protocol (ACP) requires raw, unbuffered stdio streaming (`-i`), but interactive terminal setup wizards require an interactive pseudo-TTY (`-it`).
4. **The Host Workspace Path Mismatch:** Traycer passes host paths (`/Users/...`) that don't exist inside the Linux container.

**AgentJail solves all of these out of the box with zero configuration.**

---

## Hardware & Architecture Compatibility

- **Apple Silicon Macs:** M1, M2, M3, M4 (Native `arm64` container)
- **Intel Macs:** Core i5, i7, i9, Xeon (Native `amd64` container)
- **Automatic Arch Detection:** Docker Desktop automatically detects your Mac's CPU architecture and downloads the matching native binary image. No manual flag selection required.

---

## Prerequisites (What to install first)

Before running the installer, ensure you have:
1. **Docker Desktop for Mac:** Installed and running ([Download Docker Desktop](https://www.docker.com/products/docker-desktop/) — be sure to choose "Mac with Intel chip" or "Mac with Apple chip" matching your computer).
2. **Traycer:** Installed on macOS. ([Download Traycer](https://traycer.ai))
3. **An API Key or Local LLM:**
   - **Cloud (Recommended):** A free [Google AI Studio](https://aistudio.google.com) API key for Gemini 3.7 Flash.
   - **Local:** [Ollama](https://ollama.com) running locally with `ornith:35b` or `qwen3:32b`.

---

## Step-by-Step Installation Order

### Step 1: Download & Unpack the Bundle
Clone the repository or download the turnkey bundle:
```bash
git clone https://github.com/Voltarr/hermes-docker-traycer.git
cd hermes-docker-traycer
```
*(Note: If you downloaded `agentjail-bundle.zip`, macOS places it in `~/Downloads` by default. Unzip it and run `cd ~/Downloads/agentjail-bundle`. If your browser saves downloads to your Desktop or a custom folder, adjust the `cd` path to match where you unzipped it, e.g. `cd ~/Desktop/agentjail-bundle`).*

### Step 2: Run the 1-Click Installer
Ensure Docker Desktop is open, then run:
```bash
./install.sh
```

**What `install.sh` automates for you:**
- Automatically detects CPU architecture (Intel vs. Apple Silicon).
- Launches the `hermes-sandbox` container via Docker Compose with host volume mounts.
- Sets up the smart-TTY ACP bridge wrapper at `$HOME/bin/hermes-docker`.
- Links `~/.hermes ➔ ~/.hermes-docker` so macOS host tools see your credentials.
- Applies the virtiofs permission patch, workspace path translation, and auth pre-approval.
- Flushes the background `traycer-host` daemon cache.

### Step 3: Link to Traycer
1. Open **Traycer** and sign in to your Traycer account (under **Settings ➔ Account**).
2. Click **Settings ➔ Providers ➔ Hermes Agent ➔ CLI & Args**.
3. Under Path, click **+ Add custom path** and enter:
   ```
   /Users/YOUR_USERNAME/bin/hermes-docker
   ```
   *(Or click Browse and select `bin/hermes-docker` in your home directory).*
4. Toggle the switch at the top right to **Enabled**.

### Step 4: Configure Your Model (Google Gemini or Ollama)
When you select Hermes Agent in Traycer's model dropdown:
- If prompted to set up in terminal, hit Enter to accept Google AI Studio.
- Enter your Google AI Studio API key (or local Ollama endpoint).
- Select **gemini-3.7-flash** (Reasoning effort: **Medium**).

### Step 5: Start Coding!
Go to Traycer's Start Page, select **Hermes Agent · Gemini 3.7 Flash**, and start chatting. Your agent executes tools, edits files, and runs shell commands safely quarantined inside Docker!

---

## Commercial Package ($19 Instant Download)

Want the turnkey bundle with pre-configured Docker Compose, architecture diagrams, and the printable cheat sheet?
👉 **[Buy Turnkey Package for $19 via Stripe](https://buy.stripe.com/bJecMX5g1eAZ7lC2Jm5os00)**

---

## Bonus Reference
Included in this repository is the [AI Reasoning & Intelligence Levels Cheat Sheet](assets/cheatsheet.png) to guide your model selection and thinking effort.

---

## License
MIT License. Created by Derek (@Voltarr) for GreenlitCrew.
