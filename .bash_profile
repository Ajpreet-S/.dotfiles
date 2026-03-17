#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Autostart Docker containers
docker compose -f ~/optic-systems/OS-laravel/docker-compose.yml start
