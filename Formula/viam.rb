class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/fleet/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.19.1.tar.gz"
  sha256 "9954ced321b538c87636e46da0ac3695f58330478770e849390591017464f7f8"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
