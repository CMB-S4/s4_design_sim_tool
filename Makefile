SRC = $(wildcard ./*.ipynb)
PY_SRC = $(wildcard s4_design_sim_tool/*.py)

all: s4_design_sim_tool

s4_design_sim_tool: $(SRC)
	nbdev_build_lib
	touch s4_design_sim_tool

clear: $(SRC)
	nbdev_clean_nbs --clear_all True --fname "*.ipynb"

sync:
	nbdev_update_lib

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

black: $(PY_SRC)
	black $(PY_SRC)

clean:
	rm -rf dist
