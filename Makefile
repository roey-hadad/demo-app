# Demo Makefile - Real Time College, Jenkins Fundamentals 2026
# The deck's examples call `make build` and `make test`, so they run here verbatim.

VERSION ?= 0.0.0
BUILD   ?= local
DIST    := dist

.PHONY: all build test lint clean

all: build

build:
	@mkdir -p $(DIST)
	@sed -e 's/@VERSION@/$(VERSION)/' -e 's/@BUILD@/$(BUILD)/' src/app.sh > $(DIST)/app.sh
	@chmod +x $(DIST)/app.sh
	@tar -czf $(DIST)/app-$(VERSION).tar.gz -C $(DIST) app.sh
	@echo "built $(DIST)/app-$(VERSION).tar.gz"

test:
	@APP=$(DIST)/app.sh ./tests/run-tests.sh

lint:
	@bash -n src/app.sh
	@bash -n tests/run-tests.sh
	@echo "lint ok"

clean:
	@rm -rf $(DIST) reports
