prefix ?= /usr/local
bindir = $(prefix)/bin

build:
	swift build -c release --disable-sandbox

install: build
	mkdir -p "$(bindir)"
	install ".build/release/config-validator" "$(bindir)"

uninstall:
	rm -rf "$(bindir)/config-validator"

clean:
	rm -rf .build

.PHONY: build install uninstall clean
