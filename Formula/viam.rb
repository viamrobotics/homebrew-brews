class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.109.0.tar.gz"
  sha256 "acc83961d93e95a837d2bf29d56f8e55a8077599743a35d999b294d39bbda8f8"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 54
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "880757dfc6986c0065e6466ab0f983a923c16fc7004844b33a8fbf879fa51886"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fb3837f3fe4cdce926dd1ef3e68caee305c9ffc0fe1068213eba450bd483cd5c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1ad53d0692ecccff6b27528328adeef5cce5672fa1523a51a29f66f7774b089d"
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
