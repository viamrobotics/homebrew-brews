# Viam Brews

## How do I install these formulae?

`brew install viamrobotics/brews/<formula>`

Or `brew tap viamrobotics/brews` and then `brew install <formula>`.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

## Development

To test a specific formula locally, you can try the following:

`brew reinstall --build-from-source --formula <path-to-homebrew-brews>/Formula/<formula>.rb`

Brew may tell you that you can't install _any_ formula that exists outside of a tap. You
can get around this with `sudo cp -r /path/to/homebrew-brews
/opt/homebrew/Library/Taps/[somedirectoryyoucreate]` and reinstalling from _that_ new path
instead. There might be a smarter way to do this.

To test uncommitted code that the formula relies on:
1. Temporarily, until ready to commit the formula
	1. Remove the sha256, head field
	2. Change url to be a tarball you create locally of your code (e.g. `tar -C <path-to-repo> -czf some.tgz .`) using `url "file:///<some-absolute-path-to>/some.tgz"`. You'll want to make sure the directory is cleaned of build artifacts before hand.
	3. Set version to some bogus value
2. When done, undo these changes and use the normal tooling to bump the version.
