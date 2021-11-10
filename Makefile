LINUX_SHELLS=dash bash zsh
STRICT_SHELLS=yash ksh
MACOS_SHELLS=bash zsh
SHELLSCRIPTS=makeanywhere
TEST_SHELLSCRIPTS=tests/bash-3.1 $(shell ls tests/*.sh)
ALL_SHELLSCRIPTS=$(TEST_SHELLSCRIPTS) $(SHELLSCRIPTS)
GITHUB_ACTIONS_FILES=.github/workflows/on-pr-to-main.yml

all: install

setup-cicd-integration-tests:
	apt-get update -y
	apt-get install -y $(LINUX_SHELLS) $(STRICT_SHELLS)

build-readme:
	./utils/generate_readme.py ./README.template.md > ./README.md

release:
	# Check version is valid
	[ "$(TITLE)" != "" ] || (echo Please set the title with \`make TITLE=...\`; false)
	echo "$(VERSION)" | grep '^[0-9]\+\.[0-9]\+\(\.[0-9]\+\)\?$$' || (echo Must pass version string as \`make VERSION=XX.YY[.ZZ]\`; false)
	sed -i 's/^Version .*$$/Version $(VERSION)/' README.md
	git commit -am "Bump version to $(VERSION)" -m "$(TITLE)"
	gh release create --target main "v$(VERSION)" --title "$(VERSION) $(TITLE)" $(SHELLSCRIPTS)

install-symlink-to-user:
	ln -s "$PWD/makeanywhere" "$HOME/bin/"
	./tests/test-install.sh ~/bin

install-to-user:
	cp ${SHELLSCRIPTS} ~/bin/
	./tests/test-install.sh ~/bin

install:
	cp ${SHELLSCRIPTS} /usr/bin/
	./tests/test-install.sh /usr/bin

uninstall:
	echo Remove the files: ${SHELLSCRIPTS} from your PATH

check:
	shellcheck ${ALL_SHELLSCRIPTS}

check-github-actions:
	yamllint $(GITHUB_ACTIONS_FILES)

line-count:
	cloc ${SHELLSCRIPTS}
	cloc ${TEST_SHELLSCRIPTS}
