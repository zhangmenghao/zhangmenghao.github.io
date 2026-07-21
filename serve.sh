#!/bin/bash
# Local Jekyll launcher for this site.
#
# Background: the machine's Homebrew Ruby was removed, so this project uses the
# keg-only ruby@3.3 formula. The Command Line Tools libc++ headers are also
# incomplete (missing <iostream> etc.), so native gem builds need the SDK's
# header path. And ~/.bundle is root-owned from an old sudo run, so Bundler's
# user home is relocated. This script sets all of that up, then runs Jekyll.
#
# Usage:
#   ./serve.sh              # serve at http://localhost:4000 with live reload
#   ./serve.sh build        # one-off build into _site/
#   ./serve.sh install      # re-run bundle install (after Gemfile changes)
set -e
cd "$(dirname "$0")"

export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH"
export CPLUS_INCLUDE_PATH="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/c++/v1"
export BUNDLE_USER_HOME="$HOME/.bundle-user"

case "${1:-serve}" in
  install) bundle install ;;
  build)   bundle exec jekyll build ;;
  *)       bundle exec jekyll serve --watch --port 4000 ;;
esac
