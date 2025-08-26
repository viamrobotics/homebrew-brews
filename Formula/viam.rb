class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.90.0.tar.gz"
  sha256 "695c3c2d138fddab841528d6c831b7172c1530c32056d78feac30722f25b00ec"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 25
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "88abb45f9659cf81b9d303eb6bfd5a583c4452ef36efa4b493ac4c7bdf0f0327"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f3320f95df6503aadca2de511722fb492a3c9cb748321c358bd00121b23adcaa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cf956a287634eb9995703413fb78ebc3a31d37e1ccf9e284494d2e75a333b1f2"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
