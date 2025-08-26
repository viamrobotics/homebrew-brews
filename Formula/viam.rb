class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.90.0.tar.gz"
  sha256 "695c3c2d138fddab841528d6c831b7172c1530c32056d78feac30722f25b00ec"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 24
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0cec84025cdcc36ca6ea6b8a4210cce83bb369d28fe24b23d8550c844617aac1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3370d7b826538f9df14a2062bb60e3e9e39b1cae23921469b799f7295939b220"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "685dc91a9add9289191d402360662cf2e4ded31b8a5d0bb9a370ef7ead8a2a4a"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
