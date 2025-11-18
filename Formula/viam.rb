class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.102.0.tar.gz"
  sha256 "f1a6c140d92bf7fe8ad14fb17327acf2c660be42d1d6d7e9984a790a1eda6d9a"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 41
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "84b924e8e54ac3ab16e5c27b6b81f171e65a301baab0b5d5ea80b40fcb5b1587"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d8d12f13d02462d98d856731c27468f014b0f54eb4613796a67e43ce969005ea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "10cb7e9d3c6cd3edb0d3bed17afdadfe4c5984d91e1408cd24715c06b199ea90"
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
