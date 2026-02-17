class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.114.0.tar.gz"
  sha256 "6970fb88f74f2b367cad325b48da883d1a0b2d9b56af38a558df975ddb7aafd8"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 58
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9e2985dde9791d806f58e0a4858265e0c5cf95af4bee3ca8e06426e3131bdbce"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d71bd24b5d5a3798cd305b382ba33bd1ffabc4f4ca3c198ae6324c3948d08f27"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "069ce68c95e6fd252015b4ed820a4c86bd358ef45cfd7f281a7357fbace99e4e"
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
