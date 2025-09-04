build-site: clean && copy-static
    myst build --html

copy-static:
    mkdir -p _build/html/slides
    cp slides/index.html _build/html/slides/
    cp slides/*.jpg _build/html/slides/
    cp slides/*.css _build/html/slides/
    cp -R slides/reveal.js-4.6.0 _build/html/slides/

deploy-site: build-site
    netlify deploy

clean:
    rm -rf _build/html

serve-slides:
    python -m http.server -d slides

update-mirrors: update-hg update-pijul update-darcs

[working-directory: 'mirrors/hg']
update-hg:
    hg pull {{ justfile_directory() }}

[working-directory: 'mirrors/pijul']
update-pijul:
    pijul git {{ justfile_directory() }}

[working-directory: 'mirrors']
update-darcs:
    rm -rf darcs
    (cd ..; git fast-export --all --progress 500) | darcs convert import darcs   
