# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.1.0/dist/stimulus.js"
pin "@hotwired/turbo", to: "https://ga.jspm.io/npm:@hotwired/turbo@7.2.2/dist/turbo.es2017-esm.js"
pin "@hotwired/turbo-rails", to: "https://ga.jspm.io/npm:@hotwired/turbo-rails@7.2.2/app/javascript/turbo/index.js"
pin "@rails/actioncable/src", to: "https://ga.jspm.io/npm:@rails/actioncable@7.0.4/src/index.js"
pin "flowbite", to: "https://ga.jspm.io/npm:flowbite@1.5.3/dist/flowbite.js"

# this pin works because of the link_tree directive in: test/dummy/app/assets/config/manifest.js
# that points to the relative path of the build directory for turbo_ready.js
# SEE: package.json for details on the build script
pin "turbo_ready", to: "turbo_ready.js"

pin "application", preload: true
