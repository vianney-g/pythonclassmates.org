THEME=themes/flex
THEME_REPO=https://github.com/alexandrevicenzi/Flex.git

publish:
	@git clone $(THEME_REPO) $(THEME)
	pelican content --fatal=warnings -s publishconf.py -t $(THEME)

build:
	@git clone $(THEME_REPO) $(THEME)
	pelican content --fatal=warnings -s pelicanconf.py -t $(THEME)

revert:
ifeq ($(TRAVIS_PULL_REQUEST), false)
	@echo "Build errors were encountered. Reverting last commit..."
	@git revert HEAD -n
	@git commit -m "Revert to last commit because errors were found."
	@git checkout -b errors
	@git push -f https://$(GITHUB_TOKEN)@github.com/PythonClassmates/PythonClassmates.org.git errors:master
	@echo "Last commit reverted"
else
	@echo "In a pull request. Nothing to revert."
endif

.PHONY: publish build revert
