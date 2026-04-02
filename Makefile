VENV_DIR := venv
PYTHON   := $(VENV_DIR)/bin/python
PIP      := $(VENV_DIR)/bin/pip
BOT_PID_FILE := bot.pid

.PHONY: run stop restart logs update install help

help:
	@echo "Available commands:"
	@echo "  make run      — Start the bot in the background"
	@echo "  make stop     — Stop the running bot"
	@echo "  make restart  — Restart the bot"
	@echo "  make logs     — Follow bot log output"
	@echo "  make update   — Pull latest code and reinstall deps"
	@echo "  make install  — Install/update Python dependencies"

run:
	@if [ -f $(BOT_PID_FILE) ] && kill -0 $$(cat $(BOT_PID_FILE)) 2>/dev/null; then \
	    echo "Bot is already running (PID $$(cat $(BOT_PID_FILE)))"; \
	else \
	    nohup $(PYTHON) -m wbb >> bot.log 2>&1 & echo $$! > $(BOT_PID_FILE); \
	    echo "Bot started (PID $$(cat $(BOT_PID_FILE))). Logs: bot.log"; \
	fi

stop:
	@if [ -f $(BOT_PID_FILE) ]; then \
	    if kill $$(cat $(BOT_PID_FILE)) 2>/dev/null; then \
	        rm -f $(BOT_PID_FILE) && echo "Bot stopped."; \
	    else \
	        echo "Failed to stop bot (process may have already exited)."; \
	        rm -f $(BOT_PID_FILE); \
	    fi; \
	else \
	    echo "No PID file found. Is the bot running?"; \
	fi

restart: stop run

logs:
	tail -f bot.log

update:
	bash update.sh

install:
	$(PIP) install --upgrade pip
	$(PIP) install -r requirements.txt
