class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/fleet/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.21.1.tar.gz"
  sha256 "9085a33aa1b733ed7d44bf4537ca64de301023f49be9c85690d56bf93acd03c4"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
