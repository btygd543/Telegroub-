<h1 align="center"> 
    ✨ WilliamButcherBot ✨ 
</h1>

<h3 align="center"> 
    Telegram Group Manager Bot + Userbot Written In Python Using Pyrogram.
</h3>

<p align="center">
    <a href="https://python.org">
        <img src="http://forthebadge.com/images/badges/made-with-python.svg" alt="made-with-python">
    </a>
    <a href="https://GitHub.com/TheHamkerCat">
        <img src="http://ForTheBadge.com/images/badges/built-with-love.svg" alt="built-with-love">
    </a> <br>
    <img src="https://img.shields.io/github/license/thehamkercat/WilliamButcherBot?style=for-the-badge&logo=appveyor" alt="LICENSE">
    <img src="https://img.shields.io/github/contributors/thehamkercat/WilliamButcherBot?style=for-the-badge&logo=appveyor" alt="Contributors">
    <img src="https://img.shields.io/github/repo-size/thehamkercat/WilliamButcherBot?style=for-the-badge&logo=appveyor" alt="Repository Size"> <br>
    <img src="https://img.shields.io/badge/python-3.9-green?style=for-the-badge&logo=appveyor" alt="Python Version">
    <img src="https://img.shields.io/github/issues/thehamkercat/WilliamButcherBot?style=for-the-badge&logo=appveyor" alt="Issues">
    <img src="https://img.shields.io/github/forks/thehamkercat/WilliamButcherBot?style=for-the-badge&logo=appveyor" alt="Forks">
    <img src="https://img.shields.io/github/stars/thehamkercat/WilliamButcherBot?style=for-the-badge&logo=appveyor" alt="Stars">
</p>

<h3 align="center"> 
    Ready to use method
</h3>

<p align="center">
    A Support Group and ready-to-use running instance of this bot can be found on Telegram <br>
    <a href="https://t.me/WilliamButcherBot"> WilliamButcherBot </a> | 
    <a href="https://t.me/wbbsupport"> WbbSupport </a>
</p>

<h2 align="center"> 
   ⇝ Requirements ⇜
</h2>

<p align="center">
    <a href="https://www.python.org/downloads/release/python-390/"> Python3.9 </a> |
    <a href="https://docs.pyrogram.org/intro/setup#api-keys"> Telegram API Key </a> |
    <a href="https://t.me/botfather"> Telegram Bot Token </a> | 
    <a href="https://telegra.ph/How-To-get-Mongodb-URI-04-06"> MongoDB URI </a>
</p>

<h2 align="center"> 
   ⇝ Install Locally Or On A VPS ⇜
</h2>

```console
thehamkercat@arch:~$ git clone https://github.com/thehamkercat/WilliamButcherBot
thehamkercat@arch:~$ cd WilliamButcherBot
thehamkercat@arch:~$ pip3 install -U -r requirements.txt
thehamkercat@arch:~$ cp sample_config.py config.py
```
 
<h3 align="center"> 
    Edit <b>config.py</b> with your own values
</h3>

<h2 align="center"> 
   ⇝ Run Directly ⇜
</h2>

```console
thehamkercat@arch:~$ python3 -m wbb
```

<h3 align="center"> 
   Generating Pyrogram Session For Heroku
</h3>

```console
thehamkercat@arch:~$ git clone https://github.com/thehamkercat/WilliamButcherBot
thehamkercat@arch:~$ cd WilliamButcherBot
thehamkercat@arch:~$ pip3 install pyrogram TgCrypto
thehamkercat@arch:~$ python3 str_gen.py
```

<h1 align="center"> 
   ⇝ Docker ⇜
</h1>

```console
thehamkercat@arch:~$ git clone https://github.com/thehamkercat/WilliamButcherBot
thehamkercat@arch:~$ cd WilliamButcherBot
thehamkercat@arch:~$ cp sample_config.env config.env
```

<h3 align="center"> 
    Edit <b> config.env </b> with your own values
</h3>

```console
thehamkercat@arch:~$ sudo docker build . -t wbb
thehamkercat@arch:~$ sudo docker run wbb
```

<h2 align="center">
   ⇝ Deploy on DigitalOcean Droplet (Ubuntu 24.04) ⇜
</h2>

### Prerequisites
- A DigitalOcean Droplet running **Ubuntu 24.04 LTS**
- SSH access to the Droplet (e.g. via [Termius](https://termius.com))

### Step 1 — Connect and prepare the server

```bash
apt update && apt upgrade -y
apt install -y python3 python3-pip git screen
```

### Step 2 — Clone the repository

```bash
git clone https://github.com/btygd543/Telegroub-
cd Telegroub-
```

### Step 3 — Configure the bot

```bash
cp sample_config.env config.env
nano config.env   # fill in your BOT_TOKEN, API_ID, API_HASH, MONGO_URL, etc.
```

### Step 4 — Run the automated setup (installs venv + dependencies + starts bot)

```bash
make setup
# or: bash setup.sh
```

This script will:
1. Install `python3.12-venv` if missing
2. Create a virtual environment in `venv/`
3. Install all Python dependencies from `requirements.txt`
4. Start the bot inside a `screen` session named `wbb_bot`

---

### Available `make` commands

| Command | Description |
|---|---|
| `make setup` | First-time setup: install deps and start the bot |
| `make run` | Start the bot in a background `screen` session |
| `make update` | Pull latest code from GitHub and restart the bot |
| `make stop` | Stop the running bot |
| `make logs` | Attach to the bot's screen session (detach with `Ctrl+A` then `D`) |

---

### Updating the bot

```bash
make update
# or: bash update.sh
```

This will `git pull`, stop the old bot, reinstall dependencies if needed, and restart it.

---

<h2 align="center">
   ⇝ Write new modules ⇜
</h2>

```py
# Add license text here, get it from below

from wbb import app # This is bot's client
from wbb import app2 # userbot client, import it if module is related to userbot
from pyrogram import filters # pyrogram filters
...


# For /help menu
__MODULE__ = "Module Name"
__HELP__ = "Module help message"


@app.on_message(filters.command("start"))
async def some_function(_, message):
    await message.reply_text("I'm already up!!")

# Many useful functions are in, wbb/utils/, wbb, and wbb/core/
```

<h3 align="center"> 
   And put that file in wbb/modules/, restart and test your bot.
</h3>

<b>Discover more awesome plugin add-ons for this repo</b> [@WilliamButcherBot-Add-ons](https://github.com/si-nn-er-ls/WilliamButcherBot-Add-ons).
