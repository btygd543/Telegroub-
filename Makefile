BOT_NAME = wbb_bot
PROJECT_DIR := $(shell pwd)

.PHONY: setup run update stop logs

## setup: Install dependencies and start the bot for the first time
setup:
	@bash $(PROJECT_DIR)/setup.sh

## run: Start the bot inside a screen session
run:
	@echo "==> Starting bot in screen session '$(BOT_NAME)'..."
	@screen -dmS $(BOT_NAME) bash -c "cd $(PROJECT_DIR) && source venv/bin/activate && python3 -m wbb"
	@echo "✅ Bot started. Use 'make logs' to view output."

## update: Pull latest changes from GitHub and restart the bot
update:
	@bash $(PROJECT_DIR)/update.sh

## stop: Stop the running bot
stop:
	@echo "==> Stopping bot session '$(BOT_NAME)'..."
	@if screen -list | grep -q "$(BOT_NAME)"; then \
		screen -S $(BOT_NAME) -X quit && echo "✅ Bot stopped."; \
	else \
		echo "   No running bot found."; \
	fi

## logs: Attach to the bot's screen session to view live logs
logs:
	@echo "==> Attaching to screen session '$(BOT_NAME)' (press Ctrl+A then D to detach)..."
	@screen -r $(BOT_NAME)
