setup: 
	npm install && spago build

clean: 
	rm -rf bower_components & rm -rf node_modules & rm -rf output & rm -rf build/* & rm -rf dist/* & rm -f package-lock.json

delete-snubbdom: 
	rm -rf output/snubbdom* && rm -rf .spago/snubbdom

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

dev-snubbdom: 
	make delete-snubbdom && make setup && make dev

