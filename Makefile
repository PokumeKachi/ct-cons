PHONY_TARGETS := git flake-develop
.PHONY: $(PHONY_TARGETS)

all:
	@printf '%s\n' $(PHONY_TARGETS) | fzf | xargs -r make

flake-develop:
	@bash -c '\
		h=$$(nix hash path ./flake.nix); \
		if [ "$$FLAKE_HASH" != "$$h" ]; then \
			FLAKE_HASH=$$h exec nix develop; \
			exit 1;\
		else \
			echo "FLAKE_HASH=$$FLAKE_HASH OK"; \
		fi'

git:
	git add .
	git commit
	git push
