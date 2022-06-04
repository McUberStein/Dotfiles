define confcpy =
$(shell if ! command -v $(1) > /dev/null; then echo "$(1) is not installed" > /dev/tty; else cp -r config/$(1) ~/.config/ && echo "$(1) config copied!"; fi)
endef

help: ## Shows this help screen
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

all: homemake_prepare dots_deploy portage_configure

homemake_prepare: ## Installs Home-Makefile
	@mv Home-Make/Home-Makefile ~/
	@echo 'alias homemake="make -C ~/"' >> ~/.bashrc
	@mv Home-Make/script1 ~/ResetPC
	@mkdir -p ~/.scripts
	@mv Home-Make/script2 ~/.scripts/
    
dots_deploy: ## Copy configuration files
	@$(call confcpy,"rofi")
	@$(call confcpy,"alacritty")
	@$(call confcpy,"dunst")
	@$(call confcpy,"polybar")
	@$(call confcpy,"picom")
	@cp -r config/i3 ~/.i3
    
portage_configure: ## Copy Portage configuration
	@sudo cp portage/* /etc/portage/
