class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.37.0.tar.gz"
  sha256 "6286567b0068c905ac070cd39c214a4c6f76ca81fa20ac248d68c4c9c79b1f34"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
