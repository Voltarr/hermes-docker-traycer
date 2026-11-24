# MARKETING_PLAN.md — AgentJail by Voltarr Labs
**Goal:** Generate $100+ in revenue within 6 days for Alex Finn's Vibe Code Academy Hackathon.  
**Product:** AgentJail (Turnkey Docker Sandbox Bridge for macOS AI Coding Agents)  
**Offer Link:** [https://buy.stripe.com/bJecMX5g1eAZ7lC2Jm5os00](https://buy.stripe.com/bJecMX5g1eAZ7lC2Jm5os00) ($19 One-Time)  
**Target:** 6 sales @ $19 = $114 Gross Revenue.

---

## 1. Core Positioning: The Safe Execution Layer for the Software Factory

### The Industry Shift:
Platforms like Traycer are announcing *"Software Factory coming soon."* The AI coding movement is rapidly evolving from simple chat interfaces into **autonomous agent execution loops**. 

### The Problem / Pain Point:
**Traycer is the management office; it is NOT the containment chamber.**
When an autonomous agent runs tasks, it executes shell commands, edits files, and installs packages. Running these tasks natively on macOS gives an autonomous agent **raw root-level access** to personal files, SSH keys, credentials, and local networks.

### The AgentJail Solution:
**"Keep the UI on your Mac. Trap the agent in Docker."**
AgentJail provides the hardened, sandboxed steel floor underneath Traycer and Hermes Agent. It bridges macOS UI orchestration with isolated Linux execution on Docker, with zero permission errors and automatic Apple Silicon & Intel support.

---

## 2. Target Audiences

1. **Vibe Coders & Indie Hackers (Alex Finn Community):**
   - *Desire:* Want to build autonomous AI businesses without risking their daily-driver MacBook.
   - *Trigger:* Fear of rogue scripts or broken permissions.
2. **Security-Conscious Developers:**
   - *Desire:* Enterprise-grade isolation and non-root execution.
   - *Trigger:* Understands the danger of giving LLMs access to `~/.ssh` and `~/.aws`.
3. **Multi-Node Software Factory Builders:**
   - *Desire:* Repurposing spare Intel Mac Minis or laptops as 24/7 worker nodes over Tailscale.
   - *Trigger:* Needs identical, repeatable Docker environments across heterogeneous hardware.

---

## 3. The 6-Day Campaign Sprint

### Day 1 (Foundation & Setup) — *Completed*
- [x] Working bridge built and live-tested (Hermes in Docker ➔ Traycer on macOS).
- [x] Multi-architecture support verified (Apple Silicon `arm64` + Intel `amd64`).
- [x] GitHub repo live at [https://github.com/Voltarr/hermes-docker-traycer](https://github.com/Voltarr/hermes-docker-traycer).
- [x] Live Stripe Payment Link configured ($19) with automated fulfillment.

### Day 2 (Private Dogfooding & Proof)
- [ ] Dogfood the purchase on `i7node1` (Intel Mac Mini) to prove the end-to-end buyer loop.
- [ ] Record a 90-second screen capture / Loom video showing:
  1. The danger: Raw agent execution on Mac.
  2. The fix: Running `./install.sh`.
  3. The magic: Traycer commanding Hermes inside Docker in real-time.

### Day 3 (The Public Launch Blitz)
- [ ] **Launch Thread on X (Twitter):**
  - **Hook:** *"Autonomous AI agents have root access to your Mac. That terrified me. So I spent 3 days in the trenches building AgentJail..."*
  - **Showcase:** Post the high-resolution architecture blueprint (*"The Whole Enchilada"*).
  - **Call to Action:** Link to the GitHub repo (free DIY) and the $19 Turnkey Bundle (instant setup).
  - **Tags:** @AlexFinnX, @vibe_academy, @NousResearch, @TraycerAI.
- [ ] **Direct Message to Alex Finn:**
  - Share the project, the hackathon context ($100 autonomous business challenge), and ask for feedback/retweet.

### Day 4 (Community Engagement & Hackathon Circle)
- [ ] Share the post and short demo video in the Vibe Code Academy Discord / Circle community.
- [ ] Position as a solution for fellow students who want to run autonomous agents safely without messing up their Macs.

### Day 5 (The 3-Day Engineering Post-Mortem)
- [ ] Publish an in-depth technical post: *"How we cracked macOS virtiofs sockets, non-root UID 502 boundaries, and smart-TTY stdio bridges."*
- [ ] Capture late-stage hackathon sales (target: cross 6 sales / $114).

### Day 6 (Submission & Victory Lap)
- [ ] Package final hackathon submission:
  - Live revenue proof (Stripe Dashboard showing $100+ revenue).
  - Working software factory running across M4 Mac Studio and Intel Mac Mini (`i7node1`).
  - Active GitHub repository and customer testimonials.

---

## 4. The Funnel & Monetization Economics

| Stage | Asset | Purpose |
| :--- | :--- | :--- |
| **Top of Funnel** | X Thread, Architecture Diagram, Loom Video | Build massive organic authority; highlight the root-access danger. |
| **Middle of Funnel** | GitHub Repository (`README.md`) | Open-source credibility; proves the solution is real. |
| **Bottom of Funnel** | Stripe Payment Link ($19) | One-click impulse buy for developers who want the pre-configured bundle, diagrams, and video walkthrough without troubleshooting it themselves. |

**Unit Economics:**
- Price: **$19.00**
- Stripe Fee: **$0.85** (2.9% + $0.30)
- Net Profit per Sale: **$18.15** (95.5% margin)
- **Break-Even on $100 Goal:** **6 sales = $108.90 Net Profit ($114 Gross)**

---

## 5. Viral Social Post Template (X / Twitter)

```text
Autonomous AI coding agents have raw root access to your Mac. That terrified me.

So I spent the last 3 days in the trenches building AgentJail: a turnkey Docker sandbox bridge for @TraycerAI & @NousResearch Hermes.

Traycer is the management office. 
AgentJail is the containment chamber.

Keep the UI on your Mac. Trap the agent in Docker.

✓ Apple Silicon (M1-M4) & Intel Macs auto-detected
✓ Zero virtiofs permission errors
✓ Non-root UID security
✓ Powered by Gemini 3.7 Flash + Local Ollama

Open-source repo: https://github.com/Voltarr/hermes-docker-traycer
Get the $19 1-command installer bundle: https://buy.stripe.com/bJecMX5g1eAZ7lC2Jm5os00

Built by Voltarr Labs for @AlexFinnX's @vibe_academy autonomous business hackathon! 🚀
```
