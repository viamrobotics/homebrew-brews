class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/fleet/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.27.1.tar.gz"
  sha256 "21044da9ede3e4d0f3b4ffc45126e6b152ec59ba469ddcc304d8e269e6e494a0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
