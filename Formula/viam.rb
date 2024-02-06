class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/fleet/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.20.0.tar.gz"
  sha256 "3ad8454a149505c3ba836da329aed2c16a11b32c97a365098e772bfbfcea5dbb"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
