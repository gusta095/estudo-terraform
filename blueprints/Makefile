# Variáveis
VERSION_FILE=VERSION
CHANGELOG_FILE=CHANGELOG.md
BUMP_SCRIPT=_bin/get-new-project-version.sh

DEFAULT_BRANCH := main

# Obtém a versão atual
CURRENT_VERSION=$(shell cat $(VERSION_FILE))

# Gerando nova versão
NEW_VERSION_SCRIPT := ./_bin/get-new-project-version.sh
NEW_VERSION := $(shell $(NEW_VERSION_SCRIPT) $(CURRENT_VERSION))

.PHONY: help
default: help

help:
	@echo "Opções disponíveis:"
	@echo "  make bump-version      - Atualiza a versão e gera uma nova tag"
	@echo "  make commit-version    - Commita a versão e pergunta antes de confirmar"
	@echo "  make version           - Exibe a versão atual do projeto"
	@echo "  make lint              - Execute para rodar os lints"
	@echo "  make clean-cache       - Remova pastas temporárias relacionadas ao Terraform"
	@echo "  make help              - Exibe esta mensagem de ajuda"

# Atualiza a versão e gera uma nova tag
.PHONY: bump-version
bump-version:
	@echo "Atualizando a versão..."
	@echo

# Verifica se o repositório está limpo antes de rodar o bump2version
	@if ! git diff --quiet || ! git diff --cached --quiet; then \
		echo "O repositório contém mudanças não commitadas."; \
		echo "Faça um commit ou use 'git stash' antes de rodar este comando."; \
		exit 1; \
	fi

# Continua apenas se não houver mudanças pendentes
	git checkout $(DEFAULT_BRANCH)
	@echo
	bump2version --new-version $(NEW_VERSION) major || { \
		echo "Erro ao atualizar a versão. Verifique se o comando está correto."; \
		exit 1; \
	}
	@echo "Versão atual: $(CURRENT_VERSION)"
	@echo
	@echo "Versão atualizada para: '$(NEW_VERSION)'! Verifique a nova tag:"
	@echo
	git show v$(NEW_VERSION)
	@echo
	@echo "Se estiver tudo certo, execute 'make commit-version' para publicar a nova versão."

# Commita a versão e pergunta antes de confirmar
.PHONY: commit-version
commit-version:
	@read -p "Tem certeza que deseja commit? (yes/no): " confirm && \
	if [ "$$confirm" = "yes" ]; then \
		git push --follow-tags origin $(DEFAULT_BRANCH); \
	else \
		echo "Commit cancelado."; \
	fi

# Exibe a versão atual do projeto
.PHONY: version
version:
	@echo "Versão atual: $(CURRENT_VERSION)"

.PHONY: lint
lint:
	pre-commit run --all-files --verbose --show-diff-on-failure --color always

# Remova pastas temporárias relacionadas ao Terraform
.PHONY: clean-cache
clean-cache:
	find . -type d \( -name '.terragrunt-cache' -o -name '.terraform' \) -print -prune -exec rm -rf '{}' \;
