class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.112.0.tar.gz"
  sha256 "f32563ddac14ed5867c977a53bcc77c2ad980a4ea3ef9cec97bfc41cf912b2b8"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 57
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "713a8764e61e1f90db2e5eafddc3ffe5d6ec1b26e2f8fdc0f9cd724fcf64a00c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "94a70d1f124c435febc5a5814a673e037160caca5938583a626b4a385e4417fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "edce0ad6046c68523935e1cc9ed954337e2b738f181583cb43601b4b06a8a89d"
  end

  depends_on "go" => :build

  def install
    with_env(
      TAG_VERSION: version,
    ) do
      system "make", "cli-ci"
    end
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end

  test do
    assert_match "Version", shell_output("#{bin}/viam version")
  end
end
