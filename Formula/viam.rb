class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.30.0.tar.gz"
  sha256 "38d6977e23a13277abfbb661b007673247f6706b1ff6a3a0c86f7d83ab56bd68"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
