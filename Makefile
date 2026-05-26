# Declare these targets as "phony". This tells make that these names are commands, not real files # to look for. Without .PHONY, make could get confused if a file named "install", "test", or "all" # exists in the project directory.
.PHONY: install lint flakeit reformat test all

# Install or update project dependencies.
# Run with: make install
install:
	# Upgrade pip using the current Python interpreter.
	# Using "python -m pip" is safer than calling "pip" directly,
	# because it ensures pip belongs to the same Python environment.
pip install --upgrade pip &&\ 
pip install -r requirements.txt

	# Install all dependencies listed in requirements.txt.
	python -m pip install -r requirements.txt

# Run pylint checks on the project modules/packages.
# Run with: make lint
lint:
	# Run pylint on mylib, cli, and scli.
	#
	# --disable=R,C disables:
	#   R = refactor suggestions
	#   C = convention/style suggestions
	#
	# This keeps pylint focused mainly on warnings, errors, and fatal issues.
	pylint --disable=R,C mylib cli scli
# Lint: In this Makefile, lint runs pylint --disable=R,C mylib cli scli, which checks the mylib, 
# cli, and scli parts of the project for possible bugs, warnings, bad practices, import problems, 
# undefined variables, and other code-quality issues. The option --disable=R,C tells Pylint to 
# ignore refactor suggestions and convention/style messages, so the check focuses more on 
# serious problems such as errors, warnings, and fatal issues.

# Run flake8 style and quality checks.
# Run with: make flakeit
flakeit:
	# Check only the mylib directory/package using flake8.
	# flake8 reports style violations, unused imports,
	# undefined names, and other lightweight quality issues.
	flake8 mylib
# Flakeit: In this Makefile, flakeit runs flake8 mylib, which checks only the mylib directory or 
# package using Flake8. Flake8 mainly looks for Python style problems and simple mistakes, 
# such as unused imports, undefined names, indentation issues, extra whitespace, long lines, and # PEP 8 violations. It is usually lighter and more style-focused than Pylint.

# Automatically format selected Python files.
# Run with: make reformat
reformat:
	# Format cli.py and mylib/lib.py using Black.
	# Black rewrites code into a consistent Python style.
	black cli.py mylib/lib.py

# Run the automated test suite with coverage enabled.
# Run with: make test
test:
	# Run pytest as a Python module.
	#
	# -vv: Enable very verbose output.
	#
	# --cov=mylib: Measure test coverage for the mylib package.
	#
	# --cov=cli: Measure test coverage for cli.
	#
	# --cov=scli: Measure test coverage for scli.
	#
	# tests/*.py:  Run all Python test files directly inside the tests directory.
	python -m pytest -vv --cov=mylib --cov=cli --cov=scli tests/*.py

# Run the complete workflow. Run with:  make all
#
# This executes the targets in this order:
#   1. install   2. flakeit  3. lint  4. test
all: install flakeit lint test
