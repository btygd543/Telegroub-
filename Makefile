SHELL := /bin/bash
.PHONY: setup run stop update logs install

# First-time setup on a fresh DigitalOcean Droplet
setup:
	bash setup.sh

# Start the bot in a detached screen session
run:
	@source venv/bin/activate && \
	screen -dmS wbb python3 -m wbb && \
	echo "Bot started in background screen session 'wbb'"
	@echo "Use 'make logs' to attach to the session"

# Stop the bot
stop:
	@screen -S wbb -X quit && echo "Bot stopped" || echo "Bot was not running"

# Pull latest changes and restart
update:
	bash update.sh
	$(MAKE) stop
	$(MAKE) run

# Attach to the running bot screen session
logs:
	screen -r wbb

# Install/update Python dependencies only
install:
	source venv/bin/activate && pip install -r requirements.txt
