setup: 
	npm install && spago build

clean: 
	rm -rf bower_components & rm -rf node_modules & rm -rf output & rm -rf build/* & rm -rf dist/* & rm -f package-lock.json

delete-snabbare: 
	rm -rf output/snabbare* && rm -rf .spago/snabbare

delete-build: 
	rm -rf build/*

delete-dist: 
	rm -rf dist/*

#this is the proto build commands
build: 
	spago bundle-app --main Main --to build/index.js # Build a developer-level executable file

browserify: 
	browserify build/index.js -o build/bundle.js # take that JS ex file and remove the requires so it can run in the browser

parcel: 
	parcel build index.html --dist-dir dist/ #resolve JS dependencies from the js file

serve: 
	http-server

#this is the better build commands
dev: 
	spago bundle-app --watch --clear-screen --no-install --main Main --to build/index.js --then 'make browserify && make parcel'

dev-snabbare: 
	make delete-snabbare && make setup && make dev

# EXAMPLES
build-input-example:
	docker build --build-arg EXAMPLE=Input.purs -t test-example --file Dockerfile-example .

run-input-example:
	docker run -p 8080:8080 -it test-example /bin/bash

watch:
	npx spago test \
		-wlu "-- --stash --censor-warnings --censor-stats --censor-codes=ImplicitImport,UnusedExplicitImport"
