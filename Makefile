.PHONY: run stop logs update install

# Activate venv and run the bot in a screen session
run:
	@if screen -list 2>/dev/null | grep -q "wbb"; then \
		echo "Bot is already running. Use 'make stop' first."; \
	else \
		screen -dmS wbb bash -c "source venv/bin/activate && python3 -m wbb"; \
		echo "Bot started. Use 'make logs' to view output."; \
	fi

# Stop the bot
stop:
	@if screen -list 2>/dev/null | grep -q "wbb"; then \
		screen -S wbb -X quit; \
		echo "Bot stopped."; \
	else \
		echo "Bot is not running."; \
	fi

# Attach to the bot's screen session to view logs (Ctrl+A then D to detach)
logs:
	screen -r wbb

# Pull updates from GitHub and restart the bot
update:
	./update.sh

# Install/reinstall Python dependencies
install:
	venv/bin/pip install -r requirements.txt
