class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.113.0.tar.gz"
  sha256 "0af0f05669c011f68888634e1103cc3524dad12d7490ec5e120434fda128152e"
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
