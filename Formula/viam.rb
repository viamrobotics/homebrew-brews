class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.119.2.tar.gz"
  sha256 "ca8f94f6c37b5d660e14ac9f0f5b0c572754e972a1d38f8033bddc5a3cafd4e1"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 65
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e3b96eb87548c0e9fa312d8a6824dcfeb1a1f5a8d0b76bee7e57ff5c52f222cd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fab4ac3770823673575461de1daac0c2e5293a6a0b630b97bc940781f1961810"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a18e087b5b892a9db788234c0804085c30445bee62ccb94a7ff434e0a6ec930c"
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
