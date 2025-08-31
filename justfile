build-site: clean && copy-static
    myst build --html

copy-static:
    mkdir -p _build/html/slides
    cp slides/index.html _build/html/slides/
    cp -R slides/reveal.js-4.6.0 _build/html/slides/

deploy-site: build-site
    echo "Deployment not implemented yet!"

clean:
    rm -rf _build/html
