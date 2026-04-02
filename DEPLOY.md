# 🚀 Deploy to DigitalOcean Droplet (from your phone)

> ⚠️ **Security note:** Never share your passwords or private keys in a chat, email, or public place.
> Use SSH keys instead of passwords — they are safer and are required for the GitHub Actions workflow below.

---

## Overview

This guide explains how to deploy this bot to a DigitalOcean Droplet entirely from your phone's browser, using the DigitalOcean web console and GitHub Actions for automatic deployments on every push to `main`.

---

## Step 1 — Open the DigitalOcean Web Console

1. Go to [cloud.digitalocean.com](https://cloud.digitalocean.com) on your phone's browser.
2. Click on your Droplet.
3. Click the **"Console"** button at the top of the page.
4. A terminal will open directly in your browser — no SSH client needed.

---

## Step 2 — Set Up the Droplet (run once)

Paste the following commands into the web console one by one:

**Install Docker:**
```bash
curl -fsSL https://get.docker.com | sh
```

**Clone the repository:**
```bash
cd /root
git clone https://github.com/btygd543/Telegroub-
cd Telegroub-
```

**Create and edit the config file:**
```bash
cp sample_config.env config.env
nano config.env
```
Fill in your values (`BOT_TOKEN`, `API_ID`, `API_HASH`, `DATABASE_URI`, etc.), then save with `Ctrl+X` → `Y` → `Enter`.

**Start the bot for the first time:**
```bash
docker compose up -d
```

---

## Step 3 — Generate an SSH Key for GitHub Actions

Run this in the web console to create a dedicated key pair:

```bash
ssh-keygen -t ed25519 -C "github-actions" -f ~/.ssh/github_actions -N ""
cat ~/.ssh/github_actions.pub >> ~/.ssh/authorized_keys
```

Then display the **private key** so you can copy it:
```bash
cat ~/.ssh/github_actions
```

Copy the entire output (from `-----BEGIN OPENSSH PRIVATE KEY-----` to `-----END OPENSSH PRIVATE KEY-----`). You will add this as a GitHub secret in the next step.

> ⚠️ Keep this private key secret. Do not paste it into any chat or public place.

---

## Step 4 — Add GitHub Repository Secrets

1. Go to your repository on GitHub: **Settings → Secrets and variables → Actions → New repository secret**.
2. Add the following secrets:

| Secret name      | Value                                      |
|------------------|--------------------------------------------|
| `DROPLET_HOST`   | Your Droplet's IP address (e.g. `167.99.x.x`) |
| `DROPLET_USER`   | `root`                                     |
| `DROPLET_SSH_KEY`| The private key copied in Step 3           |
| `DROPLET_PORT`   | `22`                                       |
| `DROPLET_PATH`   | `/root/Telegroub-`                         |

---

## Step 5 — Enable Automatic Deployments

The workflow file `.github/workflows/deploy.yml` is already included in this repository. Every time you push to the `main` branch, GitHub Actions will:

1. Connect to your Droplet via SSH using the key you configured.
2. Pull the latest code.
3. Restart the bot with `docker compose up -d --build`.

You can monitor runs under the **Actions** tab of the repository.

---

## Useful commands (web console)

```bash
# View live logs
docker compose logs -f

# Restart the bot manually
docker compose restart

# Stop the bot
docker compose down

# Check running containers
docker ps
```
