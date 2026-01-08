class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.108.3.tar.gz"
  sha256 "98ca98a84c4a48e0c39d3da33f09f53285a2137dccca8e0552133913a4564c8f"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 53
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7e8b6e95d5ed13e3484a372444fa7248ca82ac15b01a18aed616eb577276bc30"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9494e58fda85966b34990563caebcd510d6922d61b406b5a89f423e583b11e76"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "63fa2cd51382cad47ad1d41f041b445aed71e25cf9ed24fa5deb50a13df7f594"
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
