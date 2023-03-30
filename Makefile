TARGETS := $(shell ls scripts)

.dapper:
	@echo Downloading dapper
	@curl -sL https://releases.rancher.com/dapper/latest/dapper-$$(uname -s)-$$(uname -m) > .dapper.tmp
	@@chmod +x .dapper.tmp
	@./.dapper.tmp -v
	@mv .dapper.tmp .dapper

$(TARGETS): .dapper
	./.dapper $@

release: .dapper
	./.dapper $@

trash: .dapper
	./.dapper -m bind trash

trash-keep: .dapper
	./.dapper -m bind trash -k

deps: trash

.DEFAULT_GOAL := ci

.PHONY: $(TARGETS)

GOLANGCI_LINT_VERSION=1.52.2

.PHONY: check-golangci-lint
check-golangci-lint: install-golangci-lint ## run Go linters
	@{ \
		set -eu ; \
		ACTUAL_GOLANGCI_LINT_VERSION=$$(golangci-lint version --format short | sed -e 's%^v%%') ; \
		if [ "$${ACTUAL_GOLANGCI_LINT_VERSION}" != "${GOLANGCI_LINT_VERSION}" ] ; then \
			echo "Bad golangci-lint version $${ACTUAL_GOLANGCI_LINT_VERSION}, please install ${GOLANGCI_LINT_VERSION}" ; \
			exit 1 ; \
		fi ; \
	}

# find or download golangci-lint
.PHONY: install-golangci-lint
install-golangci-lint: ## install golangci-lint
	@{ \
		set -eu ; \
		if ! command -v golangci-lint ; then \
			curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $$(go env GOPATH)/bin v${GOLANGCI_LINT_VERSION} ; \
		fi; \
	}


.PHONY: go-build
go-build: check-golangci-lint
	./scripts/entry ci

.PHONY: install
install:
	./scripts/build install