@echo off
sage update
sage list | xargs sage install --upgrade
