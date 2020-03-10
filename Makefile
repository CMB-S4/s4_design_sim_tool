SRC = $(wildcard ./*.ipynb)

all: s4refsimtool docs

s4refsimtool: $(SRC)
	nbdev_build_lib
	touch s4refsimtool

clear: $(SRC)
	nbdev_clean_nbs --clear_all True --fname "*.ipynb"

docs_serve: docs
	cd docs && bundle exec jekyll serve

docs: $(SRC)
	nbdev_build_docs
	touch docs

test:
	nbdev_test_nbs

release: pypi
	nbdev_bump_version

pypi: dist
	twine upload --repository pypi dist/*

dist: clean
	python setup.py sdist bdist_wheel

clean:
	rm -rf dist
